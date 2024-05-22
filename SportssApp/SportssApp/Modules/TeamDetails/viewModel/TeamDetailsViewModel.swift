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
    func getTeamDetails(sportName: String, teamId: String){
        let teamURL = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&teamId=\(teamId)&APIkey=\(Constants.apiKey)"

        //https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=207&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d

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
}

