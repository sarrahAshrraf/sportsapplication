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
    var leagues: [LeagueEntity] = []
    let reachability = try! Reachability()
    
    var leaguesBySport: [String: [LeagueEntity]] = [:]
    var sports: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        viewModel = FavoriteLeaguesViewModel()
        
        leagues = viewModel.fetchAllLeagues()
        
        // Group leagues by sport
        for league in leagues {
            if let sportName = league.sportName {
                if leaguesBySport[sportName] == nil {
                    leaguesBySport[sportName] = [league]
                } else {
                    leaguesBySport[sportName]?.append(league)
                }
            }
        }
        
        // Populate sports array with unique sports
        sports = Array(leaguesBySport.keys)
        
        indicator.stopAnimating()
        tableView.reloadData()
        
        // Reachability setup
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
          return sports.count
      }

      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let sport = sports[section]
          return leaguesBySport[sport]?.count ?? 0
      }

      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell

          let sport = sports[indexPath.section]
          if let leagues = leaguesBySport[sport] {
              let league = leagues[indexPath.row]
              
              if let image = URL(string: league.leagueImg ?? "") {
                  cell.favoriteimg.kf.setImage(with: image)
              } else {
                  cell.favoriteimg.image = UIImage(named: "torphy")
              }
              cell.favoriteLabel.text = league.leagueName
          }
          
          return cell
      }

      override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          return sports[section] // Set section headers as sports
      }

    /*
    // Override to support conditional editing of the table view.
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
                self?.deleteLeague(at: indexPath)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    
    func deleteLeague(at indexPath: IndexPath) {
        let sport = sports[indexPath.section]
        if var leaguesForSport = leaguesBySport[sport] {
            let league = leaguesForSport[indexPath.row]
            viewModel.deleteLeague(league)
            leaguesForSport.remove(at: indexPath.row)
            leaguesBySport[sport] = leaguesForSport
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
            let selectedLeague = leagues[indexPath.row]
            let storyboard = UIStoryboard(name: "ScreensStoryBoard", bundle: nil)
            guard let leagueDetailsVC = storyboard.instantiateViewController(identifier: "leagueDetailsVC") as? LeagueDetailsViewController else {
                return
            }
         //   let leagueDetailsVC = LeagueDetailsViewController()
            leagueDetailsVC.leagueId = Int(selectedLeague.leagueId)
            leagueDetailsVC.leagueName = selectedLeague.leagueName ?? ""
            leagueDetailsVC.sportName = selectedLeague.sportName ?? ""
            let navigationController = UINavigationController(rootViewController: leagueDetailsVC)
//                teamVC.modalPresentationStyle = .fullScreen
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
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.3){
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        }
        
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
