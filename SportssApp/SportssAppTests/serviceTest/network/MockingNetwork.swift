//
//  MockingNetwork.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 24/05/2024.
//

import Foundation
import XCTest
@testable import SportssApp

final class MockingNetwork: XCTestCase {

    var fackNetwork : FakeNetworkResponse?
    
    override func setUpWithError() throws {
        fackNetwork = FakeNetworkResponse(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        fackNetwork = nil
    }
    
    func testFakeNetwork(){
        fackNetwork?.fetchDataFromAPI(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d", completionHandler: { (leagues : Response<League>?!) in
        
            if leagues == nil {
                XCTFail()
            }else{
                XCTAssertNotNil(leagues as Any?)
            }
        })
    }
    

}
