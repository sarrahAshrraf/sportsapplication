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
        let cell = UINib(nibName: "LeagueCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "LeagueCell")
        tableView.backgroundColor = UIColor.systemGray6
        viewModel = LeagueViewModel()
        
        viewModel.getData(sportName: sportName ) //TODO indexPath colelction
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        if let league = viewModel.result?[indexPath.row] {
            cell.leagueLabel?.text = league.leagueName
            if let logoURL = league.leagueLogo, logoURL.hasSuffix(".png") {
                if let url = URL(string: logoURL) {
                    cell.leagueImg.kf.setImage(with: url)
                } else {
                    cell.leagueImg.image = UIImage(named: "torphy")
                }
            } else {
                cell.leagueImg.image = UIImage(named: "torphy")
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
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let leagueDetailsVC = storyboard.instantiateViewController(withIdentifier: "leagueDetailsVC") as! LeagueDetailsViewController
//        leagueDetailsVC.title = "Leagues Details"
//        leagueDetailsVC.sportName = self.sportName
//        leagueDetailsVC.leagueId = (viewModel.result?[indexPath.row].leagueKey)!
//        leagueDetailsVC.leagueName = (viewModel.result?[indexPath.row].leagueName)!
//        leagueDetailsVC.leagueImage = viewModel.result?[indexPath.row].leagueLogo ?? ""
//        navigationController?.pushViewController(leagueDetailsVC, animated: true)
        //        let leagueDetailsVC = self.storyboard?.instantiateViewController(identifier: "LeaguDVC") as! DetailsOfLeagueViewController
        
        //        self.present(leagueDetailsVC, animated: true)
        
    }
}
