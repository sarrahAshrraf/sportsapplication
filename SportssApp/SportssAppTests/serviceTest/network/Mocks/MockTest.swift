//
//  LeagueDetailsViewModelTests.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import XCTest
@testable import SportssApp

struct MockResponse: Decodable {
    let success: Int
    let result: [League]
}

final class MockNetwork: XCTestCase {
        
    var fakeNetwork: MockNetworkService?
        
    override func setUpWithError() throws {
        fakeNetwork = MockNetworkService(shouldReturnError: false)
    }
        
    override func tearDownWithError() throws {
        fakeNetwork = nil
    }
        
    func testFakeNetwork() {
        fakeNetwork?.fetchDataFromAPI(url: "") { (leagues: MockResponse?) in
            if let leagues = leagues {
                XCTAssertNotNil(leagues)
            } else {
                XCTFail("Failed to fetch leagues.")
            }
        }
    }
    
    func testTeamDetails() {
        fakeNetwork?.fetchTeamDetails(sportName: "football", teamId: "123") { (response: MockResponse?) in
            if let response = response {
                XCTAssertNotNil(response)
            } else {
                XCTFail("Failed to fetch team details.")
            }
        }
    }
    
    func testTeamData() {
        fakeNetwork?.fetchTeamData(leagueID: "66", sportName: "basketball") { (response: MockResponse?) in
            if let response = response {
                XCTAssertNotNil(response)
            } else {
                XCTFail("Failed to fetch team data.")
            }
        }
    }
}
