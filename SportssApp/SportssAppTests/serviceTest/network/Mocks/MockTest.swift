//
//  LeagueDetailsViewModelTests.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import XCTest
@testable import SportssApp

struct Response: Decodable {
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
            fakeNetwork?.fetchDataFromAPI(url: "") { (leagues: Response?) in
                if let leagues = leagues {
                    XCTAssertNotNil(leagues)
                } else {
                    XCTFail("Failed to fetch leagues.")
                }
            }
        }
    }
