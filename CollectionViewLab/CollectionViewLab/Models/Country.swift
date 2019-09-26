//
//  Country.swift
//  CollectionViewLab
//
//  Created by Anthony Gonzalez on 9/26/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    let alpha2Code: String
    

    static func getFilteredCountryByName(arr: [Country], searchString: String) -> [Country] {
           return arr.filter{$0.name.lowercased().contains(searchString.lowercased())}
       }
    
    static func decodeCountriesFromData(from jsonData: Data) throws -> [Country] {
         let response = try JSONDecoder().decode([Country].self, from: jsonData)
         return response
     }
}
