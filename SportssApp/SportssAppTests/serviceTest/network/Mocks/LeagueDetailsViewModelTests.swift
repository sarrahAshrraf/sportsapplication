//
//  LeagueDetailsViewModelTests.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import XCTest
@testable import SportssApp

final class LeagueDetailsViewModelTests: XCTestCase {
    
    let mockNetworkService = MockNetworkService(shouldReturnError: false)
    let viewModel = LeagueDetailsViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUpcomingEvents() {
        let expectation = self.expectation(description: "Fetch upcoming events data")
        
        mockNetworkService.fetchDataFromApi(completionHandler: { (result: Result<Response?, Error>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Upcoming events response is nil")
            case .failure(let error):
                XCTFail("Error occurred: \(error.localizedDescription)")
            }
            expectation.fulfill()
        })
        
        viewModel.fetchUpComingEvents(sportName: "football", leagueID: "205", startDate: "2022-01-18", endDate: "2023-01-18", eventType: .upcoming)
        
        waitForExpectations(timeout: 6, handler: nil)
    }
}
