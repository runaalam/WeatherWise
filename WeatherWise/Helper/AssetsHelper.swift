//
//  AssetsHelper.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation
import SwiftUI

struct AssetsHelper {
    
    // Mapping of weather IDs to system image names
    private static let weatherIconMapping: [String: String] = [
        "01d": "sun.max",
        "01n": "moon",
        "02d": "cloud.sun",
        "02n": "cloud.moon",
        "03d": "cloud",
        "03n": "cloud",
        "04d": "cloud",
        "04n": "cloud",
        "09d": "cloud.rain",
        "09n": "cloud.rain",
        "10d": "cloud.sun.rain",
        "10n": "cloud.moon.rain",
        "11d": "cloud.bolt.rain",
        "11n": "cloud.bolt.rain",
        "13d": "cloud.snow",
        "13n": "cloud.snow",
        "50d": "cloud.fog",
        "50n": "cloud.fog"
    ]
    
    // Provides an image representing the weather condition based on the provided weather ID.
    // The weather ID is typically obtained from a weather data API.
    // Reference: https://openweathermap.org/weather-conditions#How-to-get-icon-URL
    //
    // - Parameter weatherId: The weather condition ID used to determine the appropriate icon.
    // - Returns: An Image containing the weather icon symbolizing the given weather condition.
    
    static func getWeatherIcon(weatherId: String) -> Image {
        // Use the weatherIconMapping dictionary to look up the image name
        if let imageName = weatherIconMapping[weatherId] {
            return Image(systemName: imageName)
        } else {
            // If the weather ID is not found in the mapping, return the default icon
            return Image(systemName: "star")
        }
    }
}
