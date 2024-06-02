//
//  LeagueDetailsViewModel.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import Foundation
import UIKit

/*
 fetch api data
 save into db
 fetch form db
 delete from db
 */
class LeagueDetailsViewModel{
    
    var bindResultToViewController : (() -> ()) = {}
    var bindDBToViewController: (()->()) = {}

    var resultUpComingEvents : [Event]? = [] {
        didSet{
            bindResultToViewController()
        }
    }
    
    var latestEventResult: [Event]? = []
    {
      didSet{
        bindResultToViewController()
      }
    }

    var teams: [Team]? = []
    {
      didSet{
        bindResultToViewController()
      }
    }
    
    var players: [TennisPlayer]? = []
    {
      didSet{
        bindResultToViewController()
      }
    }
    
    var tennisUpComingEvents : [TennisEvent]? = [] {
        didSet{
            bindResultToViewController()
        }
    }
    
    var tennislatestEventResult: [TennisEvent]? = []
    {
      didSet{
        bindResultToViewController()
      }
    }
    
    
    var isFav: Bool = false {
      didSet{
        bindDBToViewController()
      }
    }
    
    
    func fetchTennisUpComingEvents(sportName : String, leagueID: String, startDate: String, endDate: String, eventType: EventType){
        let leagueDetailsUrl = "https://apiv2.allsportsapi.com/\(sportName)?met=Fixtures&leagueId=\(leagueID)&from=\(startDate)&to=\(endDate)&APIkey=\(Constants.apiKey)"
        
        NetworkManager().fetchDataFromAPI(url: leagueDetailsUrl) { [weak self] (result: Response?) in
            self?.tennisUpComingEvents = result?.result
            if let result = result {
                print(result)
                print("==========Result received in upcoming events")

            } else {
                print("No result received in upcoming events")
            }
        }
    }
    
    
    
    func fetchTennisPlayersData(leagueID: String, sportName: String) {
        let teamURL = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Players&leagueId=\(leagueID)&APIkey=\(Constants.apiKey)"
        
        NetworkManager().fetchDataFromAPI(url: teamURL) { [weak self] (result: Response?) in
            self?.players = result?.result
            
            if let result = result {
                print("Players data fetched")
                print(result)
            } else {
                print("No result received in players")
            }
        }
    }

    
    
    
    func fetchUpComingEvents(sportName : String, leagueID: String, startDate: String, endDate: String, eventType: EventType){
        //https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2022-01-18&to=2023-01-18&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d
        
        
        
        let leagueDetailsUrl = "https://apiv2.allsportsapi.com/\(sportName)?met=Fixtures&leagueId=\(leagueID)&from=\(startDate)&to=\(endDate)&APIkey=\(Constants.apiKey)"
        
        NetworkManager().fetchDataFromAPI(url: leagueDetailsUrl) { [weak self] (result: Response?) in
            self?.resultUpComingEvents = result?.result
            if let result = result {
                print(result)
                print("==========Result received in upcoming events")

            } else {
                print("No result received in upcoming events")
            }
        }
    }
    
    func fetchLatestEvents(sportName : String, leagueID: String, startDate: String, endDate: String, eventType: EventType){
        
        let leagueDetailsUrl = "https://apiv2.allsportsapi.com/\(sportName)?met=Fixtures&leagueId=\(leagueID)&from=\(startDate)&to=\(endDate)&APIkey=\(Constants.apiKey)"
        
        NetworkManager().fetchDataFromAPI(url: leagueDetailsUrl) { [weak self] (result: Response?) in
            self?.latestEventResult = result?.result
            
            if let result = result {
                print(result)
                print("==========Result received in latest events")

            } else {
                print("No result received in latest events")
            }
        }
        
        
    }
    
    func fetchTeamData(leagueID: String, sportName: String){
        let teamURL = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&leagueId=\(leagueID)&APIkey=\(Constants.apiKey)"
        
//    https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=207&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d
        
        NetworkManager().fetchDataFromAPI(url: teamURL) { [weak self] (result: Response?) in
            self?.teams = result?.result
            
            if let result = result {
                print("Teaaazaaaam")
                print(result)
            } else {
                print("No result received in teams")
            }
        }
        
       
}
    func saveLeagueToDB(leagueId: Int, leagueName: String, leagueImg: String, sportName: String) {
            DatabaseManager.shared.saveLeague(leagueId: leagueId, leagueName: leagueName, leagueImg: leagueImg, sportName: sportName)
        isFav = true

        }
    
    func deleteLeagueFromDB(leagueId: Int){
        DatabaseManager.shared.deleteLeague(leagueId: leagueId)
        isFav = false
    }
    
    func isFavLeague(leagueId: Int) {
         let isFavorite = DatabaseManager.shared.isLeagueFavorite(leagueId: leagueId)
         self.isFav = isFavorite
     }
    
}


enum EventType{
  case upcoming
  case latest
}
