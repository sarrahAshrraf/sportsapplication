//
//  TeamDetailsViewController.swift
//  SportssApp
//
//  Created by Somia on 22/05/2024.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    @IBOutlet weak var playersTableView: UITableView!
    
    var viewModel: TeamDetailsViewModel!
    var indicator: UIActivityIndicatorView!
    var sportName = ""
    var playerID = 0
    var teamId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playersTableView.dataSource = self
        playersTableView.delegate = self
        playersTableView.register(UINib(nibName: "TeamDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamDetailsTableViewCell")
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        viewModel = TeamDetailsViewModel()
        
        requestData()
        bindData()
        print(teamId)
        
    }
    func requestData(){
        switch sportName{
        case "football" :   viewModel.getTeamDetails(sportName: sportName, teamId: "\(teamId)")
        case "tennis" : viewModel.getPlayerDetails(sportName: sportName, playerID: "\(playerID)")
        default:
            viewModel.getTeamDetails(sportName: sportName, teamId: "\(teamId)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows for the section
        return sportName == "football" ? viewModel.teams?.players?.count ?? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsTableViewCell", for: indexPath) as! TeamDetailsTableViewCell
        
        if sportName == "football" {
                   if let player = viewModel.teams?.players?[indexPath.row] {
                       cell.playerNameLabl.text = player.player_name
                       cell.playerAgeLabel.text = player.player_age
                       cell.playerNumberLabel.text = player.player_number
                       cell.playerPositionLabel.text = player.player_type
                       cell.playerImg.kf.setImage(with: URL(string: player.player_image ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
                   }
               } else if sportName == "tennis" {
                   cell.playerNameLabl.text = viewModel.player?.player_name
                   if let playerKey = viewModel.player?.player_key {
                       cell.playerAgeLabel.text = "\(playerKey)"
                   } else {
                       cell.playerAgeLabel.text = "" 
                   }
                   cell.playerNumberLabel.text = ""
                   cell.playerPositionLabel.text = ""
                   cell.playerImg.kf.setImage(with: URL(string: "https://static.vecteezy.com/system/resources/previews/026/367/777/original/tennis-player-cartoon-tennis-player-in-action-and-motion-vektor-illustration-vector.jpg"))
               }
        
        
//        if let player = viewModel.teams?.players?[indexPath.row]{
//            
//            cell.playerNameLabl.text = player.player_name
//            cell.playerAgeLabel.text = player.player_age
//            cell.playerNumberLabel.text = player.player_number
//            cell.playerPositionLabel.text = player.player_type
//
//            cell.playerImg.kf.setImage(with: URL(string: player.player_image ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"))
//        }
        
        return cell
    }
    
    func bindData(){
        viewModel.bindResultToViewController = { [weak self] in
            
            DispatchQueue.main.async {
                self?.logoImg.image = UIImage(named: "unknown")
                self?.logoImg.kf.setImage(with: URL(string: self?.viewModel.teams?.team_logo ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"), placeholder: UIImage(named: "unknown"))
                
                self?.teamNameLabel.text = self?.viewModel.teams?.team_name
                self?.playersTableView.reloadData()
                self?.indicator.stopAnimating()
                
            }
        }
    }


//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return viewModel.teams?.players?.count ?? 0
//    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
//        cell.textLabel?.text = viewModel.teams?.players?[indexPath.row].player_name
//
//        return cell
//    }
}
//    extension TeamDetailsTableViewController: UITableViewDataSource {
//
//    }
