//
//  Player.swift
//  SportssApp
//
//  Created by sarrah ashraf on 01/06/2024.
//

import Foundation

struct TennisPlayer: Decodable {
    let player_key: Int
    let player_name : String
//    let player_logo: String

}
//
//struct Stat: Codable {
//    let season, type, rank, titles: String
//    let matchesWon, matchesLost, hardWon, hardLost: String
//    let clayWon, clayLost, grassWon, grassLost: String?
//
//    enum CodingKeys: String, CodingKey {
//        case season, type, rank, titles
//        case matchesWon = "matches_won"
//        case matchesLost = "matches_lost"
//        case hardWon = "hard_won"
//        case hardLost = "hard_lost"
//        case clayWon = "clay_won"
//        case clayLost = "clay_lost"
//        case grassWon = "grass_won"
//        case grassLost = "grass_lost"
//    }
//}
//
//struct Tournament: Codable {
//    let name, season, type, surface, prize: String
//}
