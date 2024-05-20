//
//  NetworkManager.swift
//  SportssApp
//
//  Created by sarrah ashraf on 20/05/2024.
//

import Foundation
import Alamofire

protocol NetworkServicing{
    func fetchDataFromAPI<T: Decodable>(url: String, completionHandler : @escaping (T?) -> Void)
}
class NetworkManager: NetworkServicing {
    func fetchDataFromAPI<T>(url: String, completionHandler: @escaping (T?) -> Void) where T : Decodable {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
                   .response { resp in
                       switch resp.result {
                       case .success(let data):
                           do {
                               let result = try JSONDecoder().decode(T.self, from: data!)
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
           }
       }
