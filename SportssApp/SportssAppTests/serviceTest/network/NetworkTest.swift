//
//  NetworkTest.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 24/05/2024.
//
//
import Foundation
import XCTest
@testable import SportssApp

final class NetworkTest: XCTestCase {

    var networkService : NetworkServicing?
    
        override func setUpWithError() throws {
    
            networkService = NetworkManager()
        }
    
        override func tearDownWithError() throws {
            networkService = nil
        }
    
    
    func testportAllLeaguesData_ShouldPassed() {
            let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=959d4102f918e5ca96058a64938e54c07883cbfef2dbbfd7688e232fe8f0042a"
            let expectation = XCTestExpectation(description: "Fetch data from API")
        networkService!.fetchDataFromAPI(url: url) { (response: Response<League>?) in
                XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertGreaterThan(response?.result?.count ?? 0, 30)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5.0)
        }

        func testDecoding_ShouldPassed() {
               let expectation = self.expectation(description: "decoding")
            var decoded: [League]?
               let fetchedData = """
               [
                   {
                       "league_key": 205,
                       "league_name": "UEFA Champions League",
                       "country_name": "Eurpoe",
                       "league_logo": ".png",
                        "country_logo": ".png"
                   },
                   {
                        "league_key": 300,
                        "league_name": "UEFA Champions League",
                        "country_name": "Eurpoe",
                        "league_logo": ".png",
                         "country_logo": ".png"
                   }
               ]
               """.data(using: .utf8)!
    
            do {
                    decoded = try JSONDecoder().decode([League].self, from: fetchedData)
                } catch {
                    XCTFail("error: \(error)")
                }
               XCTAssertNotNil(decoded, "failed")
               XCTAssertEqual(decoded?.count, 2)
               expectation.fulfill()
               waitForExpectations(timeout: 5, handler: nil)
           }
    
    
    func testTeamData_ShouldPassed() {
            let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=13&APIkey=959d4102f918e5ca96058a64938e54c07883cbfef2dbbfd7688e232fe8f0042a"
            let expectation = XCTestExpectation(description: "Fetch data from API")
        networkService!.fetchDataFromAPI(url: url) { (response: Response<Team>?) in
                XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertEqual(response?.result?.count ?? 0, 1)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5.0)
        }


}






