//
//  UnitsService.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

enum Units: String {
    case standard
    case metric
    
    public func getUnitSymbol() -> String {
        switch self {
        case .standard:
            return Constants.UNIT_STANDARD_SYMBOL
        case .metric:
            return Constants.UNIT_METRIC_SYMBOL
        }
    }
    
    public func getUnitLabel() -> String {
        switch self {
        case .standard:
            return Constants.UNIT_STANDARD_LABLE
        case .metric:
            return Constants.UNIT_METRIC_LABLE
        }
    }
}

// Utility class for handling units and UserDefaults
class UnitsService {
    // UserDefaults key for storing the selected unit
    private static let unitKey = "SelectedUnit"
    
    // Get the currently selected unit from UserDefaults
    static var selectedUnit: Units {
        if let unitString = UserDefaults.standard.string(forKey: unitKey),
           let unit = Units(rawValue: unitString) {
            return unit
        } else {
            // Default to metric if no unit is selected
            return .metric
        }
    }
    
    // Set the selected unit and save it to UserDefaults
    static func setSelectedUnit(_ unit: Units) {
        UserDefaults.standard.set(unit.rawValue, forKey: unitKey)
    }
}
