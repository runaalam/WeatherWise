//
//  RequestModel.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

struct Coordinate: Decodable {
    let lon: Double
    let lat: Double
}

struct WeatherInfo: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainInfo: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

