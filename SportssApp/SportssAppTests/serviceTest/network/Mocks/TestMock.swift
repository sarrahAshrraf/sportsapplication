//
//  TestMock.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//


import XCTest
@testable import SportssApp

final class TestMock: XCTestCase {
    
    let mockNetworkService = MockNetworkService(shouldReturnError: false) 
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testMockFetchData() {
        let expectation = self.expectation(description: "Fetch data")
        
        mockNetworkService.fetchDataFromApi(completionHandler: { (result: Result<Response?, Error>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Response is nil")
            case .failure(let error):
                XCTFail("Error occurred: \(error.localizedDescription)")
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 6, handler: nil)
    }
}
