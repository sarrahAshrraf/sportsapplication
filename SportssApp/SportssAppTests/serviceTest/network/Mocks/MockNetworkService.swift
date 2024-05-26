//
//  MockNetworkService.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import Foundation
@testable import SportssApp
import Alamofire

final class MockNetworkService {
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeJsonObj: [String:Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                "country_logo": nil
            ],
            [
                "league_key": 1,
                "league_name": "UEFA European Championship",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": nil,
                "country_logo": nil
            ]
        ]
    ]
}

extension MockNetworkService {
    func fetchDataFromApi<T: Decodable>(completionHandler: @escaping (T?) -> Void) {
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJsonObj)
            AF.request("", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
                .response { resp in
                    switch resp.result {
                    case .success(let responseData):
                        guard let responseData = responseData else {
                            print("No data received from the server.")
                            completionHandler(nil)
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(T.self, from: responseData)
                            completionHandler(result)
                        } catch {
                            print("Decoding error: \(error)")
                            completionHandler(nil)
                        }
                    case .failure(let error):
                        print("Request error: \(error)")
                        completionHandler(nil)
                    }
                }
        } catch {
            print("Serialization error: \(error)")
            completionHandler(nil)
        }
    }
}
