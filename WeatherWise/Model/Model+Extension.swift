//
//  ResponseModel+Extension.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation

extension WeatherSummary {
    init(response: OneCallResponse) {
        self.latitude = response.lat
        self.longitude = response.lon
        self.timezone = response.timezone
        self.current = CurrentWeatherSummary(response: response.current)
        self.hourly = response.hourly.map { HourlyWeatherSummary(response: $0) }
        self.daily = response.daily.map { DailyWeatherSummary(response: $0) }
    }
}

extension CurrentWeatherSummary {
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

extension DailyWeatherSummary {
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

extension HourlyWeatherSummary {
    init(response: HourlyResponse) {
        self.time = Date(timeIntervalSince1970: TimeInterval(response.dt))
        self.actualTemp = Temperature(kelvin: response.temp)
        self.feelsLikeTemp = Temperature(kelvin: response.feelsLike)
        self.weatherDetails = response.weather.map { WeatherDetails(response: $0)}
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

