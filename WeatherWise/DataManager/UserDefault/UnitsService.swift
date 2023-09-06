//
//  UnitsService.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

// Enum defining different units of measurement.
enum Units: String {
    case standard // Represents the Fahrenheit
    case metric   // Represents the Celsius
    
    // Get the symbol associated with the unit.
    public func getUnitSymbol() -> String {
        switch self {
        case .standard:
            return Constants.UNIT_STANDARD_SYMBOL // Returns the symbol for the standard unit. e.g "°C"
        case .metric:
            return Constants.UNIT_METRIC_SYMBOL   // Returns the symbol for the metric unit. e.g "°F"
        }
    }
    
    // Get the label associated with the unit.
    public func getUnitLabel() -> String {
        switch self {
        case .standard:
            return Constants.UNIT_STANDARD_LABLE // Returns the label for the standard unit. e.g "Fahrenheit"
        case .metric:
            return Constants.UNIT_METRIC_LABLE   // Returns the label for the metric unit. e.g "Celsius"
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
    
    static func clearAllUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}
