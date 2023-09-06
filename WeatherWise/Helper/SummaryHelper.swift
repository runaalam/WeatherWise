//
//  SummaryHelper.swift
//  WeatherWise
//
//  Created by Runa Alam on 1/9/2023.
//

import Foundation

struct SummaryHelper {
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
    
    static func formatTemperature(_ temp: Double?) -> String {
        if let temp = temp {
            let units = UnitsService.selectedUnit
            return "\(Int(temp))\(units.getUnitSymbol())"
        } else {
            return "--º"
        }
    }
    
    static func removeAfterComma(_ input: String) -> String {
        let components = input.components(separatedBy: ",")
        if let firstPart = components.first {
            return firstPart.trimmingCharacters(in: .whitespaces)
        } else {
            return input
        }
    }
    
    static func timeToStringFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    static func dayToStringFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}


