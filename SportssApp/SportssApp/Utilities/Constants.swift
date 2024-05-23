//
//  Constants.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import Foundation
class Constants{
    static let apiKey = "995239db0133e854b94ff543d0f5c1e93a86c6ee8d60df34e502c87e932bbb6d"
       
    
}
class Utilities {
    
    static func calculateCurrentDate() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.string(from: currentDate)
        print("==========start Date")
        print(startDate)
        return startDate
    }
    
    static func calculateStartDate() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneYearFromNow = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
        let startDate = dateFormatter.string(from: oneYearFromNow)
        print("==========start Date")
        print(startDate)
        return startDate
    }
    
   static func calculateEndDate() -> String{
        
        let currentDate = Date()
        let oneYearFromNow = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = dateFormatter.string(from: oneYearFromNow)
       print("===========end Date")

       print(endDate)
        return endDate
        
    }
    

    
}
