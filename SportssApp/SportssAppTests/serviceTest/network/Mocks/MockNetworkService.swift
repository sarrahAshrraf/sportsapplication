//
//  MockNetworkService.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import Foundation
import Alamofire

final class MockNetworkService {
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchDataFromApi<T: Decodable>(completionHandler: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().async {
            do {
                sleep(1)
                let jsonData = try JSONSerialization.data(withJSONObject: self.fakeJsonObj)
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    private let fakeJsonObj: [String: Any] = [
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
