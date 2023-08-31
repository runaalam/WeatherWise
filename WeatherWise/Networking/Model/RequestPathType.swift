//
//  RequestModel.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

public enum RequestPathType {
    case weather(cityName: String)
    case forecast(cityName: String)
    case onecall(lat: Double, lon: Double)
}

