//
//  Response.swift
//  SportssApp
//
//  Created by sarrah ashraf on 20/05/2024.
//

import Foundation
struct Response<T>: Decodable where T: Decodable{
  
  var success: Int?
  var result: [T]?
  
}
