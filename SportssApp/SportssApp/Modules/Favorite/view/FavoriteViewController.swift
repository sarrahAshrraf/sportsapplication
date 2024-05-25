//
//  FavoriteViewController.swift
//  SportssApp
//
//  Created by Somia on 24/05/2024.
//

import UIKit
import Reachability

class FavoriteViewController: UITableViewController {

    var viewModel: FavoriteLeaguesViewModel!
    var indicator: UIActivityIndicatorView!
    let reachability = try! Reachability()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        viewModel = FavoriteLeaguesViewModel()
        viewModel.binddbToViewController = {[weak self] in
            self?.tableView.reloadData()
        }
        indicator.stopAnimating()
        tableView.reloadData()
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.uniqueSportCount()
      }

      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          viewModel.leaguesCount(for: section)
      }

      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell

//          cell.favoriteLabel.text = viewModel.allLeagues[indexPath.row].leagueName
//          if let image = URL(string: viewModel.allLeagues[indexPath.row].leagueImg ?? "") {
//                        cell.favoriteimg.kf.setImage(with: image)
//                    } else {
//                        cell.favoriteimg.image = UIImage(named: "torphy")
//                    }
          let league = viewModel.league(at: indexPath)
                cell.favoriteLabel.text = league.leagueName

                // Load league image asynchronously
                if let imageUrl = league.leagueImg {
                    cell.favoriteimg.kf.setImage(with: URL(string: imageUrl))
                } else {
                    cell.favoriteimg.image = UIImage(named: "torphy")
                }

                return cell
            }
//          cell.contentView.layer.cornerRadius = 55
//          cell.contentView.layer.masksToBounds = true
          
       

//
//         return cell
//     }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let allSports = viewModel.databaseManager.fetchAllLeagues().map { $0.sportName }
//        let uniqueSports = Set(allSports)
//        let sortedUniqueSports = Array(uniqueSports)
//        return sortedUniqueSports[section]
//    }

    /*
     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                confirmDelete(indexPath: indexPath)
            }
        }
        
        func confirmDelete(indexPath: IndexPath) {
            let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete ?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.viewModel.deleteLeague(leagueId: Int(Int32(self?.viewModel.allLeagues[indexPath.row].leagueId ?? 0)))
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    
    func deleteLeague(at indexPath: IndexPath) {
     //   let sport = sports[indexPath.section]
      //  if var leaguesForSport = leaguesBySport[sport] {
       //     let league = leaguesForSport[indexPath.row]
        viewModel.deleteLeague(leagueId: indexPath.row)
//            leaguesForSport.remove(at: indexPath.row)
//            leaguesBySport[sport] = leaguesForSport
        }
//        tableView.deleteRows(at: [indexPath], with: .fade)
 //   }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
            let selectedLeague = viewModel.allLeagues[indexPath.row]
            let storyboard = UIStoryboard(name: "ScreensStoryBoard", bundle: nil)
            guard let leagueDetailsVC = storyboard.instantiateViewController(identifier: "leagueDetailsVC") as? LeagueDetailsViewController else {
                return
            }
         //   let leagueDetailsVC = LeagueDetailsViewController()
            leagueDetailsVC.leagueId = Int(selectedLeague.leagueId)
            leagueDetailsVC.leagueName = selectedLeague.leagueName ?? ""
            leagueDetailsVC.sportName = selectedLeague.sportName ?? ""
            let navigationController = UINavigationController(rootViewController: leagueDetailsVC)
            navigationController.modalPresentationStyle = .fullScreen
             present(navigationController, animated: true, completion: nil)
//            present(leagueDetailsVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "You must connect to the internet to see the League details.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAllLeagues()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.3){
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 13, width: tableView.frame.width - 30, height: 30))
        headerLabel.text = viewModel.sportName(for: section)
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return viewModel.sportName(for: section)
        }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
