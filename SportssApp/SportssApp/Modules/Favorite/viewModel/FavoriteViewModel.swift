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
    var binddbToViewController: (() -> ()) = {}
    var allLeagues: [LeagueEntity] = []

    func fetchAllLeagues() {
        allLeagues = databaseManager.fetchAllLeagues()
    }

    func deleteLeague(leagueId: Int) {
        databaseManager.deleteLeague(leagueId: leagueId)
    }

    func uniqueSportCount() -> Int {
        return databaseManager.countUniqueSportNames()
    }

    func leaguesCount(for section: Int) -> Int {
        let sportName = sportName(for: section)
        return allLeagues.filter { $0.sportName == sportName }.count
    }

    func league(at indexPath: IndexPath) -> LeagueEntity {
        let sportName = sportName(for: indexPath.section)
        return allLeagues.filter { $0.sportName == sportName }[indexPath.row]
    }

    func sportName(for section: Int) -> String {
        let uniqueSports = Set(allLeagues.compactMap { $0.sportName })
        let sortedUniqueSports = Array(uniqueSports.sorted())

        guard section >= 0 && section < sortedUniqueSports.count else {
            return ""
        }

        return sortedUniqueSports[section]
    }
}

