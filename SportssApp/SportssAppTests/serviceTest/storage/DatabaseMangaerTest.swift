//
//  DatabaseMangaerTest.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 25/05/2024.
//

import Foundation
import XCTest
import CoreData
@testable import SportssApp

class DatabaseManagerTest: XCTestCase {

    var databaseManager: DatabaseManager!
    var mockPersistentContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        databaseManager = DatabaseManager.shared
        mockPersistentContainer = createMockPersistentContainer()
        databaseManager.persistentContainer = mockPersistentContainer
    }

    override func tearDownWithError() throws {
        databaseManager = nil
        mockPersistentContainer = nil
    }

    func createMockPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "SportssApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load in memory \(error)")
            }
        }
        return container
    }


    func testFetchAllLeagues() throws {
        let leagueId1 = 1
        let leagueName1 = "Premier League"
        let leagueImg1 = "premierleague.png"
        let sportName1 = "Football"
        databaseManager.saveLeague(leagueId: leagueId1, leagueName: leagueName1, leagueImg: leagueImg1, sportName: sportName1)
        
        let leagueId2 = 2
        let leagueName2 = "La Liga"
        let leagueImg2 = "laliga.png"
        let sportName2 = "Football"
        databaseManager.saveLeague(leagueId: leagueId2, leagueName: leagueName2, leagueImg: leagueImg2, sportName: sportName2)

        let leagues = databaseManager.fetchAllLeagues()
        XCTAssertNotNil(leagues)
        XCTAssertEqual(leagues.count, 2)
    }

    func testIsLeagueFavorite() throws {
        let leagueId = 3
        let leagueName = "Serie A"
        let leagueImg = "serie.png"
        let sportName = "Football"
        databaseManager.saveLeague(leagueId: leagueId, leagueName: leagueName, leagueImg: leagueImg, sportName: sportName)

        let isFavorite = databaseManager.isLeagueFavorite(leagueId: leagueId)
        XCTAssertTrue(isFavorite)
    }
}
