//
//  FakeNetworkResponse.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 24/05/2024.
//

import Foundation
@testable import SportssApp

class FakeNetworkResponse {
    
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool ) {
        self.shouldReturnError = shouldReturnError
    }
    
    let response : Response = Response(success: 1, result: [League(),League(),League()])
    
    
    enum ResponseWithError : Error{
        case responseError
    }
}

extension FakeNetworkResponse : NetworkServicing {
    func fetchDataFromAPI<T>(url: String, completionHandler: @escaping (T?) -> Void) where T : Decodable {
        if shouldReturnError{
            completionHandler(nil)
        }else{
            completionHandler(response as? T)
        }
    }
    
 

}
