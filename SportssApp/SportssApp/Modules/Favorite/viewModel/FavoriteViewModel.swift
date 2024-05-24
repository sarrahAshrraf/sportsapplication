//
//  FavoriteViewModel.swift
//  SportssApp
//
//  Created by Somia on 24/05/2024.
//

import Foundation
import CoreData

class FavoriteLeaguesViewModel {
    private let databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager = DatabaseManager.shared) {
        self.databaseManager = databaseManager
    }
    
    func fetchAllLeagues() -> [LeagueEntity] {
        return databaseManager.fetchAllLeagues()
    }
    
    func deleteLeague(_ league: LeagueEntity) {
        databaseManager.deleteLeague(league: league)
        }
}
