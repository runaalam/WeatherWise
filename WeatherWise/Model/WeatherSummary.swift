//
//  WeatherSummary.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation
import SwiftUI

struct WeatherSummary {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let current: CurrentWeatherSummary
    let daily: [DailyWeatherSummary]
    let hourly: [HourlyWeatherSummary]
}

struct CurrentWeatherSummary {
    let time: Date
    let sunriseTime: Date
    let sunsetTime: Date
    let actualTemp: Temperature
    let feelsLikeTemp: Temperature
    let pressure: Int
    let humidity: Int
    let uvIndex: Double
    let windSpeed: Double
    let windAngle: Int
    var windDirection: String {
        return SummaryHelper.getWindDirection(windAngle: windAngle)
    }
    let weatherDetails: [WeatherDetails]
}

struct DailyWeatherSummary {
    let time: Date
    let sunriseTime: Date
    let sunsetTime: Date
    let dayTemp: Temperature
    let nightTemp: Temperature
    let minTemp: Temperature
    let maxTemp: Temperature
    let eveTemp: Temperature
    let mornTemp: Temperature
    let weatherDetails: [WeatherDetails]
}

struct HourlyWeatherSummary {
    let time: Date
    let actualTemp: Temperature
    let feelsLikeTemp: Temperature
    let weatherDetails: [WeatherDetails]
}

struct WeatherDetails {
  let weatherID: Int
  let weatherCondition: String
  let weatherDescription: String
  let weatherIconID: String
  var weatherIcon: Image? {
      return AssetsHelper.getWeatherIcon(weatherId: weatherIconID)
  }
}
