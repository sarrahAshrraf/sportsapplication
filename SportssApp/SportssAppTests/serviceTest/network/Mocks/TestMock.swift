//
//  TestMock.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import XCTest
@testable import SportssApp

final class TestMock: XCTestCase {
    
    var network: NetworkServicing?
    
    override func setUpWithError() throws {
        network = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        network = nil
    }
    
    func testDecoding() {
        var decoded: [League]?
        let fetchedData = """
        [
            {
                "league_key": 205,
                "league_name": "UEFA Champions League",
                "country_name": "Europe",
                "league_logo": ".png",
                "country_logo": ".png"
            },
            {
                "league_key": 300,
                "league_name": "UEFA Champions League",
                "country_name": "Europe",
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
    }
}
