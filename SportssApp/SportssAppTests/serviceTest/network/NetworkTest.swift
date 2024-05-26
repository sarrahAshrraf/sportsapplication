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


//struct Response<T>: Decodable where T: Decodable{
//
//  var success: Int?
//  var result: [T]?
//
//}


final class NetworkTest: XCTestCase {

    var networkService : NetworkServicing?
    
        override func setUpWithError() throws {
    
            networkService = NetworkManager()
        }
    
        override func tearDownWithError() throws {
            networkService = nil
        }
    
    
    func testportAllLeaguesData_ShouldPassed() {
            let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d"
            let expectation = XCTestExpectation(description: "Fetch data from API")
        networkService!.fetchDataFromAPI(url: url) { (response: Response<League>?) in
                XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertGreaterThan(response?.result?.count ?? 0, 30)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5.0)
        }
    
    func testgetSportAllLeaguesData_ShouldFail(){
    let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d"
    let expectation = XCTestExpectation(description: "Failed To Fetch data from API")
        networkService!.fetchDataFromAPI(url: url) { (response: Response<League>?) in
        XCTAssertNil(response)
        XCTAssertEqual(response?.success, 1)
        XCTAssertLessThan(response?.result?.count ?? 0, 3)
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
    
}


        func testDecoding_ShouldPassed() {
               let expectation = self.expectation(description: "decoding")
            var decoded: [League]?
    /*
     var league_key : Int?
     var league_name : String?
     var country_key : Int?
     var country_name : String?
     var league_logo : String?
     var country_logo : String?
     */
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
            let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=13&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d"
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






