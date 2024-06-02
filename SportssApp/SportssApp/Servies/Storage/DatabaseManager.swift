//
//  DatabaseManager.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportssApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func saveLeague(leagueId: Int, leagueName: String, leagueImg: String, sportName: String) {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        
        do {
            let existingLeagues = try context.fetch(fetchRequest)
            for league in existingLeagues {
                context.delete(league)
            }
        } catch {
            print("Failed to fetch or delete leagues: \(error)")
        }
        
        let league = LeagueEntity(context: context)
        league.leagueId = Int32(leagueId)
        league.leagueName = leagueName
        league.leagueImg = leagueImg
        league.sportName = sportName
        
        saveContext()
    }
    
    
    func deleteLeague(league: LeagueEntity) {
        let context = persistentContainer.viewContext
        context.delete(league)
        saveContext()
    }
    
 
    func fetchAllLeagues() -> [LeagueEntity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        
        do {
            let leagues = try context.fetch(fetchRequest)
            print(leagues.count)
            return leagues
        } catch {
            print("Failed to fetch leagues: \(error)")
            return []
        }
    }
    
    
    func deleteLeague(leagueId: Int) {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        
        do {
            let leagues = try context.fetch(fetchRequest)
            if let leagueToDelete = leagues.first {
                context.delete(leagueToDelete)
                saveContext()
            } else {
                print("No league found with ID \(leagueId)")
            }
        } catch {
            print("Failed to fetch or delete league: \(error)")
        }
    }
    
    func isLeagueFavorite(leagueId: Int) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %d", leagueId)
        
        do {
            let leagues = try context.fetch(fetchRequest)
            return !leagues.isEmpty
        } catch {
            print("Failed to fetch league: \(error)")
            return false
        }
    }
    
    func countUniqueSportNames() -> Int {
         let context = persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "LeagueEntity")
         fetchRequest.resultType = .dictionaryResultType
         fetchRequest.propertiesToFetch = ["sportName"]
         fetchRequest.returnsDistinctResults = true

         do {
             let results = try context.fetch(fetchRequest)
             return results.count
         } catch {
             print("Failed to fetch unique sport names: \(error)")
             return 0
         }
    } 
    

}
