//
//  MockNetworkService.swift
//  SportssAppTests
//
//  Created by Somia on 26/05/2024.
//

import Foundation
@testable import SportssApp

    final class MockNetworkService {
        
        var shouldReturnError: Bool
        
        init(shouldReturnError: Bool) {
            self.shouldReturnError = shouldReturnError
        }
        
        let response : MockResponse = MockResponse(success: 1, result: [League(),League(),League()])
        
        enum ResponseWithError: Error {
            case responseError
        }
        
        func fetchDataFromAPI<T>(url: String, completionHandler: @escaping (T?) -> Void) where T : Decodable {
            if shouldReturnError {
                completionHandler(nil)
            } else {
                completionHandler(response as? T)
            }
        }
        
        func fetchTeamDetails<T>(sportName: String, teamId: String, completionHandler: @escaping (T?) -> Void) where T: Decodable {
                if shouldReturnError {
                    completionHandler(nil)
                } else {
                    completionHandler(response as? T)
                }
            }
        
        func fetchTeamData<T>(leagueID: String, sportName: String, completionHandler: @escaping (T?) -> Void) where T: Decodable {
            if shouldReturnError {
                completionHandler(nil)
            } else {
                completionHandler(response as? T)
            }
        }
        
    }
