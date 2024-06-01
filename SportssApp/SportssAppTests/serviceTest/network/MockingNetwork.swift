//
//  MockingNetwork.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 24/05/2024.
//
//done
import Foundation
import XCTest
@testable import SportssApp

final class MockingNetwork: XCTestCase {

    var fakeNetwork : FakeNetworkResponse?
    
    override func setUpWithError() throws {
        fakeNetwork = FakeNetworkResponse(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        fakeNetwork = nil
    }
    
    func testFakeNetwork(){
        
        fakeNetwork?.fetchDataFromAPI(url: "", completionHandler: { (leagues : Response<League>?!) in
        
            if leagues == nil {
                XCTFail()
            }else{
                XCTAssertNotNil(leagues as Any?)
            }
        })
    }
    

}
