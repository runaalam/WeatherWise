//
//  HourlySummary.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation

struct HourlySummary {
    let time: Date
    let actualTemp: Temperature
    let feelsLikeTemp: Temperature
    let weatherDetails: [WeatherDetails]
}

extension HourlySummary {
    init(response: HourlyResponse) {
        self.time = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.actualTemp = Temperature(kelvin: response.temp)
        self.feelsLikeTemp = Temperature(kelvin: response.feelsLike)
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0)}
    }
}
