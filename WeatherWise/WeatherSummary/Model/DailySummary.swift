//
//  DailySummary.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation

struct DailySummary: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let sunriseTime: Date
    let sunsetTime: Date
    let dayTemp: Double
    let nightTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let eveTemp: Double
    let mornTemp: Double
    let weatherDetails: [WeatherDetails]
    
    var dayString: String {
        SummaryHelper.dayToStringFormatter(date)
    }
    
    var maxTempString: String {
        SummaryHelper.getTempStringWithSymbol(maxTemp, unit: UnitsService.selectedUnit)
    }
    
    var minTempString: String {
        SummaryHelper.getTempStringWithSymbol(minTemp, unit: UnitsService.selectedUnit)
    }
}

extension DailySummary {
    init(response: DailyResponse) {
        self.date = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.sunriseTime = Date(timeIntervalSince1970: TimeInterval(response.sunrise))
        self.sunsetTime = Date(timeIntervalSince1970: TimeInterval(response.sunset))
        self.dayTemp = response.temp.day
        self.nightTemp = response.temp.night
        self.minTemp = response.temp.min
        self.maxTemp = response.temp.max
        self.eveTemp = response.temp.eve
        self.mornTemp = response.temp.morn
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0) }
    }
}
