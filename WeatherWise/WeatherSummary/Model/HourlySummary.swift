//
//  HourlySummary.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation
import SwiftUI

struct HourlySummary: Identifiable {
    let id: UUID = UUID()
    let time: Date
    let actualTemp: Double
    let feelsLikeTemp: Double
    let weatherDetails: [WeatherDetails]
    
    var hourlyActualTemp: String {
        SummaryHelper.getTempStringWithSymbol(actualTemp, unit: UnitsService.selectedUnit)
    }
    
    var currentTime: String {
        SummaryHelper.timeToStringFormatter(time)
    }
    
    var hourlyIcon: Image {
        if let iconId = weatherDetails.first?.weatherIconID {
            return AssetsHelper.getWeatherIcon(weatherId: iconId)
        } else {
            return Image(systemName: "star")
        }
    }
}

extension HourlySummary {
    init(response: HourlyResponse) {
        self.time = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.actualTemp = response.temp
        self.feelsLikeTemp = response.feelsLike
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0)}
    }
}
