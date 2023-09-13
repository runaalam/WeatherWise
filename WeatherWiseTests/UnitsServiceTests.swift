//
//  UnitsServiceTests.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 7/9/2023.
//

import XCTest

@testable import WeatherWise
class UnitsServiceTests: XCTestCase {
    
    // Test the Units enum getUnitSymbol method
    func testUnitsEnumGetUnitSymbol() {
        XCTAssertEqual(Units.imperial.getUnitSymbol(), "°F")
        XCTAssertEqual(Units.metric.getUnitSymbol(), "°C")
    }
    
    // Test the Units enum getUnitLabel method
    func testUnitsEnumGetUnitLabel() {
        XCTAssertEqual(Units.imperial.getUnitLabel(), "Fahrenheit")
        XCTAssertEqual(Units.metric.getUnitLabel(), "Celsius")
    }
    
    // Test UnitsService selectedUnit and setSelectedUnit methods
    func testUnitsServiceSelectedUnit() {
        // Clear user default so that it remove saved unit and able to test default unit settings
        UnitsService.clearAllUserDefaults()
        // Ensure that the default unit is metric
        XCTAssertEqual(UnitsService.selectedUnit, Units.metric)
        
        // Set and retrieve a custom selected unit
        UnitsService.setSelectedUnit(Units.imperial)
        XCTAssertEqual(UnitsService.selectedUnit, Units.imperial)
    }
}

