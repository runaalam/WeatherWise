//
//  CitySearchResult.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation

struct CitySearchResult: Identifiable {
    let id = UUID()
    let city: String
    let country: String
    let lat: Double? = nil
    let lon: Double? = nil
}
