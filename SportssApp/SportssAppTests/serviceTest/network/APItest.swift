

//
//  TestAPITests.swift
//  SportssAppTests
//
//  Created by Somia on 29/05/2024.
//

import XCTest
@testable import SportssApp

class TestAPITests: XCTestCase {

    var networkService: NetworkServicing!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = NetworkManager() // Initialize NetworkManager here
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }

    func testFetchDataFromApi() {
        let expectation = expectation(description: "Wait for fetching data ..")

        let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=207&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d"

        networkService.fetchDataFromAPI(url: url) { (response: Response<Team>?) in
            XCTAssertNotNil(response, "Response is nil")
            
            XCTAssertNotNil(response?.result, "Result is nil")

            print(" ----------------------------\(response?.result?[0].team_name)")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}




