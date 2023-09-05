//
//  CurrentSummary.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation

struct CurrentSummary {
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

extension CurrentSummary {
    init(response: CurrentResponse) {
        self.time = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.sunriseTime = Date(timeIntervalSince1970: TimeInterval(response.sunrise))
        self.sunsetTime = Date(timeIntervalSince1970: TimeInterval(response.sunset))
        self.actualTemp = Temperature(kelvin: response.temp)
        self.feelsLikeTemp = Temperature(kelvin: response.feelsLike)
        self.pressure = response.pressure
        self.humidity = response.humidity
        self.uvIndex = response.uvi
        self.windSpeed = response.windSpeed
        self.windAngle = response.windDeg
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0) }
    }
}
