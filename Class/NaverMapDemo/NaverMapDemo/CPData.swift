//
//  CData.swift
//  NaverMapDemo
//
//  Created by 이민영 on 2024/01/29.
//

import Foundation

struct CPData: Codable, Identifiable {
    let id: String
    let name: String
    let flag: String
    let code: String
    let dial_code: String
    let pattern: String
    let limit: Int
    
    static let allCountries:[CPData] = Bundle.main.decode("CountryNumbers.json")

}



extension Bundle {
    func decode<T : Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        guard let countries = try? decoder.decode(T.self, from: data) else {
            fatalError("There is problemm in parsing the data")
            
        }

        return countries
    }
}

