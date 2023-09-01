//
//  ForecastReponse.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

struct FourDayForecastResponse: Decodable {

    struct ListItem: Decodable {
        let dt: Int
        let main: MainInfo
        let weather: [WeatherInfo]
        let dt_txt: String
    }
    struct CityInfo: Decodable {
        let id: Int
        let name: String
        let coord: Coordinate
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: Int
        let sunset: Int
    }
    
    let city: CityInfo
    let list: [ListItem]
}
