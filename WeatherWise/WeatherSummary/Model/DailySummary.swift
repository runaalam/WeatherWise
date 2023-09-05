//
//  DailySummary.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation

struct DailySummary {
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

extension DailySummary {
    init(response: DailyResponse) {
        self.time = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.sunriseTime = Date(timeIntervalSince1970: TimeInterval(response.sunrise))
        self.sunsetTime = Date(timeIntervalSince1970: TimeInterval(response.sunset))
        self.dayTemp =  Temperature(kelvin: response.temp.day)
        self.nightTemp = Temperature(kelvin: response.temp.night)
        self.minTemp = Temperature(kelvin: response.temp.min)
        self.maxTemp = Temperature(kelvin: response.temp.max)
        self.eveTemp = Temperature(kelvin: response.temp.eve)
        self.mornTemp = Temperature(kelvin: response.temp.morn)
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0) }
    }
}
