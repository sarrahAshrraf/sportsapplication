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


struct Statistic: Codable {
    let type: String
    let home: String
    let away: String
}



// MARK: - Event for Tennis
struct TennisEvent: Codable {
    let eventKey: String
    let eventDate: String
    let eventTime: String
    let eventFirstPlayer: String
    let firstPlayerKey: String
    let eventSecondPlayer: String
    let secondPlayerKey: String
    let eventFinalResult: String
    let eventGameResult: String
    let eventServe: String?
    let eventWinner: String?
    let eventStatus: String
    let countryName: String
    let leagueName: String
    let leagueKey: String
    let leagueRound: String
    let leagueSeason: String
    let eventLive: String
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    let pointByPoint: [PointByPoint]
    let scores: [Score]

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFinalResult = "event_final_result"
        case eventGameResult = "event_game_result"
        case eventServe = "event_serve"
        case eventWinner = "event_winner"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        case pointByPoint = "pointbypoint"
        case scores = "scores"
    }
}

// MARK: - PointByPoint
struct PointByPoint: Codable {
    let setNumber: String
    let numberGame: String
    let playerServed: String
    let serveWinner: String
    let serveLost: String?
    let score: String
    let points: [Point]

    enum CodingKeys: String, CodingKey {
        case setNumber = "set_number"
        case numberGame = "number_game"
        case playerServed = "player_served"
        case serveWinner = "serve_winner"
        case serveLost = "serve_lost"
        case score = "score"
        case points = "points"
    }
}

// MARK: - Point
struct Point: Codable {
    let numberPoint: String
    let score: String
    let breakPoint: String?
    let setPoint: String?
    let matchPoint: String?

    enum CodingKeys: String, CodingKey {
        case numberPoint = "number_point"
        case score = "score"
        case breakPoint = "break_point"
        case setPoint = "set_point"
        case matchPoint = "match_point"
    }
}

// MARK: - Score
struct Score: Codable {
    let scoreFirst: String
    let scoreSecond: String
    let scoreSet: String

    enum CodingKeys: String, CodingKey {
        case scoreFirst = "score_first"
        case scoreSecond = "score_second"
        case scoreSet = "score_set"
    }
}
