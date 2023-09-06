//
//  City.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation

struct City: Identifiable, Codable {
    let id: String
    let name: String
    let country: String
    let coordinate: Coordinate
    
    public init(id: String = UUID().uuidString, name: String, country: String, coordinate: Coordinate = Coordinate()) {
        self.id = id
        self.name = name
        self.country = country
        self.coordinate = coordinate
    }
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
    
    init(lon: Double = 0, lat: Double = 0) {
       self.lon = lon
       self.lat = lat
   }
}

