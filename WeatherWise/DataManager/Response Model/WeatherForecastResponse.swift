//
//  ForecastReponse.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

struct WeatherForecastResponse: Decodable {

    struct Coordinate: Decodable {
        let lon: Double
        let lat: Double
    }
    struct Main: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct ListItem: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
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
