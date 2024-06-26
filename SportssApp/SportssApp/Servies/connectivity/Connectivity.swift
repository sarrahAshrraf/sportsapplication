//
//  Connectivity.swift
//  SportssApp
//
//  Created by sarrah ashraf on 31/05/2024.
//

import Foundation
import Reachability

class Connectivity {
    
    static let connectivityInstance = Connectivity()
    
    var reachability: Reachability? {
        do {
            return try Reachability()
        } catch {
            print("Unable to Reach")
            return nil
        }
    }
    
    func isConnectedToInternet() -> Bool {
        return reachability?.isReachable ?? false
    }
    
    private init() {
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
