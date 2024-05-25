//
//  FavoriteViewModel.swift
//  SportssApp
//
//  Created by Somia on 24/05/2024.
//

import Foundation
import CoreData

class FavoriteLeaguesViewModel {
    
    let databaseManager = DatabaseManager.shared
    var binddbToViewController:(()->()) = {}
    var allLeagues:[LeagueEntity] = []{
    didSet{
        binddbToViewController()
    }
}
    
    func fetchAllLeagues() {
        allLeagues = databaseManager.fetchAllLeagues()
    }
    
    func deleteLeague(_ league: LeagueEntity) {
        databaseManager.deleteLeague(league: league)
        }
}
