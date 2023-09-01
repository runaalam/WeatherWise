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
}


