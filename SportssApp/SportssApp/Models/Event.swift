//
//  Event.swift
//  SportssApp
//
//  Created by sarrah ashraf on 20/05/2024.
//

import Foundation

struct Event: Decodable{
    let eventKey: Int?
    let eventDay: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventHalftimeResult: String?
    let leagueLogo: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let leagueKey: Int?
    let leagueName: String?
    let leagueRound: String?
    let eventStadium: String?
    let leagueSeason: String?
    let finalResult: String?
    
    enum CodingKeys: String, CodingKey{
        case eventKey = "event_key"
        case eventDay = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case leagueLogo = "league_logo"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case leagueName = "league_name"
        case leagueRound = "league_round"
        case leagueKey = "league_key"
        case eventStadium = "event_stadium"
        case leagueSeason = "league_season"
        case finalResult = "event_final_result"
    }
}
class GoalScorer: Codable {
    let time: String
    let homeScorer: String?
    let homeScorerId: String?
    let homeAssist: String?
    let homeAssistId: String?
    let score: String
    let awayScorer: String?
    let awayScorerId: String?
    let awayAssist: String?
    let awayAssistId: String?
    let info: String?
    let infoTime: String
}

struct Substitute: Codable {
    let time: String
    let homeScorer: [String]?
    let homeAssist: String?
    let score: String
    let awayScorer: SubstitutePlayer
    let awayAssist: String?
    let info: String?
    let infoTime: String
}

struct SubstitutePlayer: Codable {
    let `in`: String
    let out: String
    let inId: String
    let outId: String
}

struct Card: Codable {
    let time: String
    let homeFault: String?
    let card: String
    let awayFault: String?
    let info: String?
    let homePlayerId: String?
    let awayPlayerId: String?
    let infoTime: String
}

struct Vars: Codable {
    let homeTeam: [String]
    let awayTeam: [String]
}

struct Lineups: Codable {
    let homeTeam: Team
    let awayTeam: Team
}

struct Team: Codable {
    let startingLineups: [Player]
    let substitutes: [Player]
    let coaches: [Coach]
    let missingPlayers: [String]
}

struct Player: Codable {
    let player: String
    let playerNumber: Int
    let playerPosition: Int
    let playerCountry: String?
    let playerKey: String
    let infoTime: String
}

struct Coach: Codable {
    let coache: String
    let coacheCountry: String?
}

struct Statistic: Codable {
    let type: String
    let home: String
    let away: String
}
