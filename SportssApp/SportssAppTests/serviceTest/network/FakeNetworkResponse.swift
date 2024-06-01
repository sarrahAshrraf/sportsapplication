//
//  FakeNetworkResponse.swift
//  SportssAppTests
//
//  Created by sarrah ashraf on 24/05/2024.
//
//done
import Foundation
@testable import SportssApp

class FakeNetworkResponse {
    
    var shouldReturnError : Bool
    init(shouldReturnError : Bool ) {
        self.shouldReturnError = shouldReturnError
    }
    
    var response: Response<League>?
    let fakeResponse: [String: Any] = [
        "result": [
            [
                "league_key": 205,
                "league_name": "UEFA Champions League",
                "country_key": nil,
                "country_name": "Eurpoe",
                "league_logo": ".png",
                "country_logo": ".png"
            ],
            [
                "league_key": 300,
                "league_name": "UEFA Champions League",
                "country_key": nil,
                "country_name": "Eurpoe",
                "league_logo": ".png",
                "country_logo": ".png"
            ]
        ]
    ]
    
    
    enum ResponseWithError : Error{
        case responseError
    }
}

extension FakeNetworkResponse : NetworkServicing {
    func fetchDataFromAPI<T>(url: String, completionHandler: @escaping (T?) -> Void) where T : Decodable {
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeResponse)
            response = try JSONDecoder().decode(Response<League>.self, from: data)
        if shouldReturnError{
            completionHandler(nil)
        }else{
            completionHandler(response as? T)
        }
        } catch {
            completionHandler(nil)
        }
    }
    
 

}
