//
//  AllLeaguesTableViewController.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import UIKit
import Kingfisher
import Alamofire
class AllLeaguesTableViewController: UITableViewController {
    //leagueCell
    var viewModel : LeagueViewModel!
    var sportName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sportName)
        self.title = "\(sportName)"

        let cell = UINib(nibName: "LeagueCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "LeagueCell")
        tableView.backgroundColor = UIColor.systemGray6
        viewModel = LeagueViewModel()
        
        viewModel.getData(sportName: sportName )
        print(viewModel.getData(sportName: sportName ))
        viewModel.bindResultToViewController = { [weak self] in
            
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        if let league = viewModel.result?[indexPath.row] {
            cell.leagueLabel?.text = league.league_name
            if let logoURL = league.league_logo, logoURL.hasSuffix(".png") {
                if let url = URL(string: logoURL) {
                    cell.leagueImg.kf.setImage(with: url)
                } else {
                    cell.leagueImg.image = UIImage(named: "tor")
                }
            } else {
                cell.leagueImg.image = UIImage(named: "tor")
            }
            
        }
        //        cell.buttonAction = { [weak self] in
        //                        guard let self = self else { return }
        //                        if let youtubeURL = league.strYoutube {
        //                            self.navigateToWebView(urlString: youtubeURL)
        //                        }
        //                    }
        
        return cell
    }
    //    func navigateToWebView(urlString: String) {
    //        let webViewController = WebViewController()
    //        webViewController.youtubeUrl = urlString
    //        self.navigationController?.pushViewController(webViewController, animated: true)
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ScreensStoryBoard", bundle: nil)
        if let leagueDetailsVC = storyboard.instantiateViewController(withIdentifier: "leagueDetailsVC") as? LeagueDetailsViewController {
            if viewModel.checkInternetConnectivity(){
                
                leagueDetailsVC.sportName = self.sportName
                leagueDetailsVC.leagueId = viewModel.result?[indexPath.row].league_key ?? 0
                leagueDetailsVC.leagueName = viewModel.result?[indexPath.row].league_name ?? ""
                leagueDetailsVC.leagueImage = viewModel.result?[indexPath.row].league_logo ?? ""
                let navigationController = UINavigationController(rootViewController: leagueDetailsVC)
                
                leagueDetailsVC.modalPresentationStyle = .fullScreen
                present(navigationController, animated: true, completion: nil)
                //            navigationController?.pushViewController(leagueDetailsVC, animated: true)
                print(viewModel.result?[indexPath.row].league_key ?? 0) //10887 tennis
            }else {
                let alert = UIAlertController(title: "No Internet Connection", message: "You must connect to the internet to see the Leagues", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
            }
        }
    }


}
