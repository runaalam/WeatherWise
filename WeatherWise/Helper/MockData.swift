//
//  MockData.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

struct MockData {
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
}
