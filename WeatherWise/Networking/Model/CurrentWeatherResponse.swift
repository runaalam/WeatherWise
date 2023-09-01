//
//  CurrentWeatherResponse.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    struct SystemInfo: Decodable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }

    let coord: Coordinate
    let weather: [WeatherInfo]
    let main: MainInfo
    let dt: Int
    let sys: SystemInfo
    let timezone: Int
    let id: Int
    let name: String
}
