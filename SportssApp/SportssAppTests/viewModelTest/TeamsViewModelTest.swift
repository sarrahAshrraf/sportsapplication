//
//  TeamsViewModelTest.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 26/05/2024.
//

import Foundation
import XCTest
@testable import SportssApp

class TeamsViewModelTest: XCTestCase {
    var viewModel: TeamDetailsViewModel!

    override func setUpWithError() throws {
        viewModel = TeamDetailsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetTeamDetails_ShouldPass() throws {
        let expectation = self.expectation(description: "get data successfully")
        viewModel.getTeamDetails(sportName: "football", teamId: "17")
        viewModel.bindResultToViewController = {
            XCTAssertNotNil(self.viewModel.teams)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testGetTennisPlayerDetails_ShouldPass() throws {
        let expectation = self.expectation(description: "get data successfully")
        viewModel.getPlayerDetails(sportName: "tennis", playerID: "2170")
        viewModel.bindResultToViewController = {
            XCTAssertNotNil(self.viewModel.player)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    
    
    
    
    
    
    
}
