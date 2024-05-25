//
//  League.swift
//  SportssApp
//
//  Created by sarrah ashraf on 20/05/2024.
//

import Foundation

//class League: Codable {
//    let leagueKey: Int
//    let leagueName: String
//    let countryKey: Int?
//    let countryName: String
//    let leagueLogo: String?
//    let countryLogo: String?
//
//    enum CodingKeys: String, CodingKey {
//        case leagueKey = "league_key"
//        case leagueName = "league_name"
//        case countryKey = "country_key"
//        case countryName = "country_name"
//        case leagueLogo = "league_logo"
//        case countryLogo = "country_logo"
//    }
//}

class League : Decodable{
    var league_key : Int?
    var league_name : String?
    var country_key : Int?
    var country_name : String?
    var league_logo : String?
    var country_logo : String?
}
