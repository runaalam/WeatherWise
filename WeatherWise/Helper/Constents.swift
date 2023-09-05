//
//  Constents.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

struct Constants {
    static let URL_BASE = "https://api.openweathermap.org"
    static let API_KEY = "d2b7cc5b2b6eb31951f90eb9a76ecbe8"
    static let API_VERSION = "/data/2.5/"
    static let HEADER_CONTENT_KEY = "Content-Type"
    static let HEADER_CONTENT_VALUE = "application/json"
    static let URL_PATH_WEATHER = "weather"
    static let URL_PATH_FORECAST = "forecast"
    static let URL_PATH_ONECALL = "onecall"
    
    static let UNIT_METRIC_SYMBOL = "°C"
    static let UNIT_STANDARD_SYMBOL = "°F"
    static let UNIT_METRIC_LABLE = "Celsius"
    static let UNIT_STANDARD_LABLE = "Fahrenheit"
    
    static let WIND_ANGLE_NORTH = "N"
    static let WIND_ANGLE_NORTH_EAST = "NE"
    static let WIND_ANGLE_EAST = "E"
    static let WIND_ANGLE_SOUTH_EAST = "SE"
    static let WIND_ANGLE_SOUTH = "S"
    static let WIND_ANGLE_SOUTH_WEST = "SW"
    static let WIND_ANGLE_WEST = "W"
    static let WIND_ANGLE_NORTH_WEST = "NW"
}
