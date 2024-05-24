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
    

    

}
