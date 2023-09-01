//
//  OnecallResponse.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

// MARK: - OneCallResponse

struct OneCallResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: CurrentResponse
    let hourly: [HourlyResponse]
    let daily: [DailyResponse]
}

// MARK: - CurrentResponse

struct CurrentResponse: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int?
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherResponse]
    let rain: RainResponse?
  
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
    }
}

// MARK: - RainResponse

struct RainResponse: Decodable {
  let the1H: Double?
  
  enum CodingKeys: String, CodingKey {
    case the1H = "1h"
  }
}

// MARK: - WeatherResponse

struct WeatherResponse: Decodable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
  
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - DailyResponse

struct DailyResponse: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: TempResponse
    let feelsLike: FeelsLikeResponse
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherResponse]
    let clouds: Int
    let rain: Double?
    let uvi: Double
  
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, rain, uvi
    }
}

// MARK: - FeelsLikeResponse

struct FeelsLikeResponse: Decodable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// MARK: - TempResponse

struct TempResponse: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// MARK: - HourlyResponse

struct HourlyResponse: Decodable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherResponse]
    let rain: RainResponse?
    
    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity, clouds
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
    }
}
