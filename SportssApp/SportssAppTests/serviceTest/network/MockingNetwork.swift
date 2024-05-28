////
////  MockingNetwork.swift
////  SportssAppTests
////
////  Created by sarrah ashraf on 24/05/2024.
////
//
//import Foundation
//import XCTest
//@testable import SportssApp
//
//final class MockingNetwork: XCTestCase {
//
//    var fackNetwork : FakeNetworkResponse?
//    
//    override func setUpWithError() throws {
//        fackNetwork = FakeNetworkResponse(shouldReturnError: false)
//    }
//
//    override func tearDownWithError() throws {
//        fackNetwork = nil
//    }
//    
//    func testFakeNetwork(){
//        fackNetwork?.fetchDataFromAPI(url: "", completionHandler: { (leagues : Response!) in
//        
//            if leagues == nil {
//                XCTFail()
//            }else{
//                XCTAssertNotNil(leagues)
//            }
//        })
//    }
//    
//
//}
