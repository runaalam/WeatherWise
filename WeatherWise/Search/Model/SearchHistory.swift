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
    var tempString: String {
        SummaryHelper.formatTemperature(currentTemperature)
    }
    
    var cityName: String {
        SummaryHelper.removeAfterComma(city.name)
    }
}

extension SearchHistory {
    init(city: City, response: WeatherCurrentResponse) {
        self.city = city
        self.currentTemperature = response.main.temp
        self.weatherDescription = response.weather.first?.description ?? ""
        self.weatherIcon = response.weather.first?.icon ?? ""
        self.date = Date(timeIntervalSince1970: TimeInterval(response.dt))
    }
}

