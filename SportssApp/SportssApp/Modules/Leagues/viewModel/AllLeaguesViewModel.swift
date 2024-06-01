//
//  AllLeaguesViewModel.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import Foundation
import Alamofire

class LeagueViewModel{
    
var bindResultToViewController : (() -> ()) = {}

var result : [League]? = [] {
    didSet{
        bindResultToViewController()
    }
}

func getData(sportName : String){
    let leagueUrl = "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(Constants.apiKey)"

    NetworkManager().fetchDataFromAPI(url: leagueUrl) { [weak self] (result : Response?) in
        self?.result = result?.result
    }
}
    
    
    //https://apiv2.allsportsapi.com/football/?&met=Videos&eventId=86392&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644
//    
//    func getVedio(sportName: String, eventId: String){
//        let leagueVedio = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Videos&eventId=\(eventId)&APIkey=\(Constants.apiKey)"
//        
//        
//        
//        
//    }
}
