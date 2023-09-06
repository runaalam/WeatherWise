//
//  MockData.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

struct MockData {
    static func getMockCity() -> City {
        return City(name: "Los Angeles", country: "United States", coordinate: Coordinate(lon: -122.4194, lat: 37.7749))
    }
    
    static func getMockCities() -> [City] {
        return [
            City(name: "Sydney", country: "Australia", coordinate: Coordinate(lon: 151.2093, lat: -33.8688)),
            City(name: "New York", country: "United States", coordinate: Coordinate(lon: -74.006, lat: 40.7128)),
            City(name: "London", country: "United Kingdom", coordinate: Coordinate(lon: -0.128, lat: 51.5074)),
            City(name: "Paris", country: "France", coordinate: Coordinate(lon: 2.3522, lat: 48.8566)),
            City(name: "Tokyo", country: "Japan", coordinate: Coordinate(lon: 139.6917, lat: 35.6895)),
        ]
    }
    
    static func getMockSearchHistory() -> [SearchHistory] {
        let mockSearchHistory: [SearchHistory] = [
            SearchHistory(city: City(name: "Sydney", country: "Australia", coordinate: Coordinate(lon: 151.2093, lat: -33.8688)),
                          currentTemperature:  11.4,
                          weatherDescription: "Mostly sunny",
                          weatherIcon: "01d",
                          date: Date()),
            
            SearchHistory(city: City(name: "New York", country: "United States", coordinate: Coordinate(lon: -74.006, lat: 40.7128)),
                          currentTemperature: 33.30,
                          weatherDescription: "Partly cloudy",
                          weatherIcon: "02d",
                          date: Date().addingTimeInterval(-86400)), // One day ago
            
            SearchHistory(city: City(name: "London", country: "United Kingdom", coordinate: Coordinate(lon: -0.128, lat: 51.5074)),
                          currentTemperature: 27.98,
                          weatherDescription: "Cloudy",
                          weatherIcon: "03d",
                          date: Date().addingTimeInterval(-172800)), // Two days ago
            
            SearchHistory(city: City(name: "Paris", country: "France", coordinate: Coordinate(lon: 2.3522, lat: 48.8566)),
                          currentTemperature: 32.89,
                          weatherDescription: "Partly cloudy",
                          weatherIcon: "02d",
                          date: Date().addingTimeInterval(-259200)), // Three days ago
            
            SearchHistory(city: City(name: "Tokyo", country: "Japan", coordinate: Coordinate(lon: 139.6917, lat: 35.6895)),
                          currentTemperature: 26.85,
                          weatherDescription: "Sunny",
                          weatherIcon: "01d",
                          date: Date().addingTimeInterval(-345600)), // Four days ago
        ]
        
        return mockSearchHistory
    }
    
    static func getMockWeatherDetails() -> [WeatherDetails] {
        let weatherDetails = [
            WeatherDetails(weatherID: 800, weatherCondition: "Clear", weatherDescription: "Clear sky", weatherIconID: "01d"),
            WeatherDetails(weatherID: 801, weatherCondition: "Clouds", weatherDescription: "Few clouds", weatherIconID: "02d"),
            WeatherDetails(weatherID: 500, weatherCondition: "Rain", weatherDescription: "Light rain", weatherIconID: "10d"),
            WeatherDetails(weatherID: 802, weatherCondition: "Clouds", weatherDescription: "Scattered clouds", weatherIconID: "03d"),
            WeatherDetails(weatherID: 600, weatherCondition: "Snow", weatherDescription: "Light snow", weatherIconID: "13d")
        ]
        return weatherDetails
    }
    
    static func getMockCurrentSummary() -> CurrentSummary {
        let currentSummary = CurrentSummary(
            time: Date(),
            sunriseTime: Date(),
            sunsetTime: Date(),
            actualTemp: 25.0,
            feelsLikeTemp: 26.5,
            pressure: 1010,
            humidity: 70,
            uvIndex: 7.5,
            windSpeed: 5.0,
            windAngle: 45,
            weatherDetails: MockData.getMockWeatherDetails()
        )
        
        return currentSummary
    }
    
    static func generateConsecutiveHourlySummaries() -> [HourlySummary] {
        var hourlySummaries: [HourlySummary] = []
        
        // Get the current date and time
        var currentDate = Date()
        
        // Generate 24 consecutive hourly summaries
        for _ in 0..<24 {
            let randomActualTemp = Double.random(in: 20.0...30.0)
            let randomFeelsLikeTemp = Double.random(in: 19.0...31.0)
            
            let hourlySummary = HourlySummary(
                time: currentDate,
                actualTemp: randomActualTemp,
                feelsLikeTemp: randomFeelsLikeTemp,
                weatherDetails: [
                    WeatherDetails(
                        weatherID: 802,
                        weatherCondition: "Clouds",
                        weatherDescription: "Scattered clouds",
                        weatherIconID: "03d"
                    )
                ]
            )
            
            hourlySummaries.append(hourlySummary)
            
            // Increment the current date by one hour
            currentDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate) ?? Date()
        }
        
        return hourlySummaries
    }
    
    
    func getSingleHourlySummary() -> HourlySummary {
        let randomActualTemp = Double.random(in: 20.0...30.0)
        let randomFeelsLikeTemp = Double.random(in: 19.0...31.0)
        
        let hourlySummary = HourlySummary(
            time: Date(),
            actualTemp: randomActualTemp,
            feelsLikeTemp: randomFeelsLikeTemp,
            weatherDetails: [
                WeatherDetails(
                    weatherID: 802,
                    weatherCondition: "Clouds",
                    weatherDescription: "Scattered clouds",
                    weatherIconID: "03d"
                )
            ]
        )
        return hourlySummary
    }
    
    static func getMockWeeklySummary() -> [DailySummary] {
        var dailySummaries: [DailySummary] = []
        let calendar = Calendar.current
        var currentDate = calendar.startOfDay(for: Date())
        
        for _ in 1...7 {
            let summary = generateRandomDailySummary(forDate: currentDate)
            dailySummaries.append(summary)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dailySummaries
    }
    
    static func generateRandomDailySummary(forDate date: Date) -> DailySummary {
        let randomDayTemp = Double.random(in: 20.0...30.0)
        let dailySummary = DailySummary(
            date: date,
            sunriseTime: date,
            sunsetTime: date,
            dayTemp: randomDayTemp,
            nightTemp: randomDayTemp - 5.0,
            minTemp: randomDayTemp - 7.0,
            maxTemp: randomDayTemp + 5.0,
            eveTemp: randomDayTemp - 2.0,
            mornTemp: randomDayTemp - 3.0,
            weatherDetails: [
                WeatherDetails(weatherID: 801, weatherCondition: "Clouds", weatherDescription: "Few clouds", weatherIconID: "02d")
            ]
        )
        return dailySummary
    }
    
    static func getMockCityWeatherSummary() -> WeatherSummary {
        let mockWeatherSummary = WeatherSummary(latitude: 37.7749,
                                                longitude: -122.4194,
                                                timezone: "America/Los_Angeles",
                                                current: MockData.getMockCurrentSummary(),
                                                daily: MockData.getMockWeeklySummary(),
                                                hourly: MockData.generateConsecutiveHourlySummaries())
        return mockWeatherSummary
    }
}
