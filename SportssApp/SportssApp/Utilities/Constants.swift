//
//  Constants.swift
//  SportssApp
//
//  Created by sarrah ashraf on 22/05/2024.
//

import Foundation
class Constants{
    static let apiKey = "959d4102f918e5ca96058a64938e54c07883cbfef2dbbfd7688e232fe8f0042a"
       
    
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
