//
//  TeamDetailsViewModel.swift
//  SportssApp
//
//  Created by Somia on 22/05/2024.
//

import Foundation

class TeamDetailsViewModel{
    var bindResultToViewController: (()->()) = {}
    var teams: Team? { didSet{ bindResultToViewController() } }
    var player: TennisPlayer? { didSet{ bindResultToViewController() } }

    func getTeamDetails(sportName: String, teamId: String){
        let teamURL = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&teamId=\(teamId)&APIkey=\(Constants.apiKey)"

        NetworkManager().fetchDataFromAPI(url: teamURL) { [weak self] (result: Response?) in
            self?.teams = result?.result?[0]
            if let result = result{
                print("done")
                print(result)
            }
            else{
                print("no response")
            }
        }
    }
    
    //Tennis
    func getPlayerDetails(sportName: String, playerID: String){
        let teamURL = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Players&playerId=\(playerID)&APIkey=\(Constants.apiKey)"

//    https://apiv2.allsportsapi.com/tennis/?&met=Players&playerId=1905&APIkey=959d4102f918e5ca96058a64938e54c07883cbfef2dbbfd7688e232fe8f0042a

        NetworkManager().fetchDataFromAPI(url: teamURL) { [weak self] (result: Response?) in
            self?.player = result?.result?[0]
            if let result = result{
                print("done")
                print(result)
            }
            else{
                print("no response")
            }
        }
    }
    
}


//tennis
//    https://apiv2.allsportsapi.com/tennis/?&met=Players&playerId=1905&APIkey=959d4102f918e5ca96058a64938e54c07883cbfef2dbbfd7688e232fe8f0042a

