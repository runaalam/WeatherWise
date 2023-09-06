//
//  SummaryHelper.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation

struct SummaryHelper {
    // Converts wind direction number to angle 
    // Reference: http://snowfence.umn.edu/Components/winddirectionanddegrees.htm
    // - Parameter windAngle: The wind direction angle in degrees (0-360)
    // - Returns: A string representing the wind direction (e.g., "N", "NE", "E", etc.)
    static func getWindDirection(windAngle: Int) -> String {
        if windAngle >= 337 || windAngle < 23 {
            return Constants.WIND_ANGLE_NORTH
        }
        if windAngle < 67 {
            return Constants.WIND_ANGLE_NORTH_EAST
        }
        if windAngle < 113 {
            return Constants.WIND_ANGLE_EAST
        }
        if windAngle < 157 {
            return Constants.WIND_ANGLE_SOUTH_EAST
        }
        if windAngle < 203 {
            return Constants.WIND_ANGLE_SOUTH
        }
        if windAngle < 247 {
            return Constants.WIND_ANGLE_SOUTH_WEST
        }
        if windAngle < 293 {
            return Constants.WIND_ANGLE_WEST
        }
        return Constants.WIND_ANGLE_NORTH_WEST
    }
    
    // Formats a temperature value according to the selected unit of measurement
    // - Parameters:
    //   - temp: The temperature value to format
    //   - unit: The selected unit of measurement (default is user's preference)
    // - Returns: A formatted string representing the temperature (e.g., "25°C", "72°F")
    static func formatTemperature(_ temp: Double?, unit: Units = UnitsService.selectedUnit) -> String {
        if let temp = temp {
            let units = UnitsService.selectedUnit
            return "\(Int(temp))\(units.getUnitSymbol())"
        } else {
            return "--º"
        }
    }
    
    // Removes text after the first comma in a string
    // - Parameter input: The input string
    // - Returns: The input string with text after the first comma removed
    static func removeAfterComma(_ input: String) -> String {
        let components = input.components(separatedBy: ",")
        if let firstPart = components.first {
            return firstPart.trimmingCharacters(in: .whitespaces)
        } else {
            return input
        }
    }
    
    // Converts a date to a string in a short time format (e.g., "3:30 PM")
    // - Parameter date: The input date to convert
    // - Returns: A string representing the time in short format
    static func timeToStringFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    // Converts a date to a string representing the day of the week (e.g., "Monday")
    // - Parameter date: The input date to convert
    // - Returns: A string representing the day of the week
    static func dayToStringFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}


