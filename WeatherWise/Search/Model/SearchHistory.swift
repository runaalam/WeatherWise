//
//  WeatherHistory.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation

struct SearchHistory {
    let city: City
    let currentTemperature: Double
    let weatherDescription: String
    let weatherIcon: String
    let date: Date
    let unitType: Units
    
    var tempString: String {
        let formattedValue = SummaryHelper.convertTempUnit(currentTemperature,
                                                       actualType: UnitsService.selectedUnit,
                                                       convertedType: unitType)
        return SummaryHelper.getTempStringWithSymbol(formattedValue, unit: unitType)
    }
    
    var cityName: String {
        SummaryHelper.removeAfterComma(city.name)
    }
    
    init(city: City, currentTemperature: Double, weatherDescription: String, weatherIcon: String, date: Date, unitType: Units) {
        self.city = city
        self.currentTemperature = currentTemperature
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
        self.date = date
        self.unitType = unitType
    }
}

extension SearchHistory {
    init(city: City, response: WeatherCurrentResponse, unitType: Units = UnitsService.selectedUnit) {
        self.city = city
        self.currentTemperature = response.main.temp
        self.weatherDescription = response.weather.first?.description ?? ""
        self.weatherIcon = response.weather.first?.icon ?? ""
        self.date = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.unitType = unitType
    }
}

