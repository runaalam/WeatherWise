//
//  WeatherCurrentResponse.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation

struct WeatherCurrentResponse: Decodable {
    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }

    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }

    struct Clouds: Decodable {
        let all: Int
    }

    struct Sys: Decodable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }

    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

