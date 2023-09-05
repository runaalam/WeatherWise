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
    let current: CurrentSummary
    let daily: [DailySummary]
    let hourly: [HourlySummary]
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

extension WeatherSummary {
    init(response: OneCallWeatherResponse) {
        self.latitude = response.lat
        self.longitude = response.lon
        self.timezone = response.timezone
        self.current = CurrentSummary(response: response.current)
        self.hourly = response.hourly.map { HourlySummary(response: $0) }
        self.daily = response.daily.map { DailySummary(response: $0) }
    }
}

extension WeatherDetails {
    init(response: WeatherResponse) {
        self.weatherID = response.id
        self.weatherCondition = response.main
        self.weatherDescription = response.weatherDescription
        self.weatherIconID = response.icon
    }
}
