//
//  FavoriteViewModel.swift
//  SportssApp
//
//  Created by Somia on 24/05/2024.
//

import Foundation
import CoreData


struct LeagueSection {
    let sportName: String
    var leagues: [LeagueEntity]
}

class FavoriteLeaguesViewModel {

    let databaseManager = DatabaseManager.shared
    var binddbToViewController: (() -> ()) = {}
    var leagueSections: [LeagueSection] = []

    func fetchAllLeagues() {
        let allLeagues = databaseManager.fetchAllLeagues()
        let groupedLeagues = Dictionary(grouping: allLeagues, by: { $0.sportName })
        leagueSections = groupedLeagues.map { LeagueSection(sportName: $0.key ?? "", leagues: $0.value) }
        binddbToViewController()
    }


    func deleteLeague(leagueId: Int) {
        databaseManager.deleteLeague(leagueId: leagueId)
        fetchAllLeagues()
    }

    func numberOfSections() -> Int {
        return leagueSections.count
    }

    func numberOfLeagues(inSection section: Int) -> Int {
        return leagueSections[section].leagues.count
    }

    func league(at indexPath: IndexPath) -> LeagueEntity {
        return leagueSections[indexPath.section].leagues[indexPath.row]
    }

    func sportName(forSection section: Int) -> String {
        return leagueSections[section].sportName
    }
    
    func checkInternetConnectivity()->Bool{
        
        return Connectivity.connectivityInstance.isConnectedToInternet()
    }
}


