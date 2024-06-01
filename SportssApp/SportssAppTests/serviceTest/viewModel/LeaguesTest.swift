//
//  LeagueViewModelTest.swift
//  SportssAppTests
//
//  Created by Somia on 29/05/2024.
//

import XCTest
@testable import SportssApp

class TestLeagueViewModel: XCTestCase {

    var viewModel: LeagueViewModel!

    override func setUpWithError() throws {
        viewModel = LeagueViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetData() throws {
        let expectation = self.expectation(description: "Data fetched successfully")
        viewModel.getData(sportName: "football")
        viewModel.bindResultToViewController = {
            XCTAssertNotNil(self.viewModel.result, "Result should not be nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
