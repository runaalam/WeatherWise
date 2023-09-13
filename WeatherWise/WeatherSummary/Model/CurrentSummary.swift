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
    let actualTemp: Double
    let feelsLikeTemp: Double
    let pressure: Int
    let humidity: Int
    let uvIndex: Double
    let windSpeed: Double
    let windAngle: Int
    let weatherDetails: [WeatherDetails]
    
    var currentTempString: String {
        SummaryHelper.getTempStringWithSymbol(actualTemp, unit: UnitsService.selectedUnit)
    }
    
    var feelsLikeTempFormatter: String {
        SummaryHelper.getTempStringWithSymbol(feelsLikeTemp, unit: UnitsService.selectedUnit)
    }
    
    var sunriseTimeString: String {
        SummaryHelper.timeToStringFormatter(sunsetTime)
    }
    
    var sunsetTimeString: String {
        SummaryHelper.timeToStringFormatter(sunsetTime)
    }
    
    var currentTempDescription: String {
        if let description = weatherDetails.first?.weatherDescription {
            return description
        } else {
            return ""
        }
    }
    
    var humidityString: String {
        "\(humidity)%"
    }
    
    var windSpeedString: String {
      let kmh = windSpeed
      let mph = kmh / 1.609
      return String(format: "%.0f mi/h", mph)
    }
    
    var windDirection: String {
        SummaryHelper.getWindDirection(windAngle: windAngle)
    }
    
    init(
        time: Date = Date(),
        sunriseTime: Date = Date(),
        sunsetTime: Date = Date(),
        actualTemp: Double = 0.0,
        feelsLikeTemp: Double = 0.0,
        pressure: Int = 0,
        humidity: Int = 0,
        uvIndex: Double = 0.0,
        windSpeed: Double = 0.0,
        windAngle: Int = 0,
        weatherDetails: [WeatherDetails] = []
    ) {
        self.time = time
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.actualTemp = actualTemp
        self.feelsLikeTemp = feelsLikeTemp
        self.pressure = pressure
        self.humidity = humidity
        self.uvIndex = uvIndex
        self.windSpeed = windSpeed
        self.windAngle = windAngle
        self.weatherDetails = weatherDetails
    }
}

extension CurrentSummary {
    init(response: CurrentResponse) {
        self.time = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.sunriseTime = Date(timeIntervalSince1970: TimeInterval(response.sunrise))
        self.sunsetTime = Date(timeIntervalSince1970: TimeInterval(response.sunset))
        self.actualTemp =  response.temp
        self.feelsLikeTemp = response.feelsLike
        self.pressure = response.pressure
        self.humidity = response.humidity
        self.uvIndex = response.uvi
        self.windSpeed = response.windSpeed
        self.windAngle = response.windDeg
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0) }
    }
}
