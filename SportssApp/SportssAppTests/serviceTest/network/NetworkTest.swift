//
//  NetworkTest.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 24/05/2024.
//



import Foundation
import XCTest
@testable import SportssApp

struct Response: Decodable {
    let success: Int
    let result: [League]
}

final class NetworkTest: XCTestCase {
  
    var network : NetworkServicing?
    
    override func setUpWithError() throws {
        
        network = NetworkManager()
    }

    override func tearDownWithError() throws {
        network = nil
    }

//    func testLoadDataFromURLwithURL() {
//        let expectation = expectation(description: "Waiting for fetching api calls...")
//
//        network?.fetchDataFromAPI(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce") { (leagues: Response?) in
//            if leagues == nil {
//                XCTFail()
//            } else {
//                XCTAssert(leagues?.success == 1)
//                expectation.fulfill()
//            }
//        }
//        
//        waitForExpectations(timeout: 10)
//    }
    
    
    
    func testDecoding() {
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
}

//import XCTest
//@testable import SportssApp
//
//final class NetworkTest: XCTestCase{
//    var network: NetworkServicing!
//
//        override func setUp() {
//            super.setUp()
//            network = NetworkManager()
//        }
//
//        override func tearDown() {
//            network = nil
//            super.tearDown()
//        }
//    
//    func fetchLeague(){}
//    func fetchTeams(){
//        
//        
//        
//        
//        
//    }
//    func fetchUpComingEvents(){}
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
