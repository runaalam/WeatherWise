//
//  WeatherWiseTests.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 30/8/2023.
//

import XCTest

@testable import WeatherWise
final class SummaryHelperTests: XCTestCase {
    
    func testGetWindDirection() {
        XCTAssertEqual(SummaryHelper.getWindDirection(windAngle: 0), "N")
        XCTAssertEqual(SummaryHelper.getWindDirection(windAngle: 45), "NE")
        XCTAssertEqual(SummaryHelper.getWindDirection(windAngle: 90), "E")
    }
    
    func testFormatTemperature() {
        XCTAssertEqual(SummaryHelper.getTempStringWithSymbol(25, unit: Units.metric), "25°C")
        XCTAssertEqual(SummaryHelper.getTempStringWithSymbol(72.0, unit: Units.imperial), "72°F")
        XCTAssertEqual(SummaryHelper.getTempStringWithSymbol(nil, unit: Units.imperial), "--º")
    }
    
    func testRemoveAfterComma() {
        // Given string with ","
        var givenStr = "New York, USA"
        var expectedStr = "New York"
        XCTAssertEqual(SummaryHelper.removeAfterComma(givenStr), "New York")
        
        // Given string without ","
        givenStr = "London"
        expectedStr = "London"
        
        XCTAssertEqual(SummaryHelper.removeAfterComma(givenStr),expectedStr)
    }
    
    func testTimeToStringFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        // Given time
        let date = dateFormatter.date(from: "15:30:00")!
        
        XCTAssertEqual(SummaryHelper.timeToStringFormatter(date), "3:30 PM")
    }
    
    func testDayToStringFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Given date
        let date = dateFormatter.date(from: "2023-09-06")!
        
        XCTAssertEqual(SummaryHelper.dayToStringFormatter(date), "Wednesday")
    }
    
    func testConvertTemp() {
        // Test converting from Fahrenheit to Celsius
        let fahrenheitValue: Double = 68.0
        let celsiusValue = SummaryHelper.convertTempUnit(fahrenheitValue, actualType: .imperial, convertedType: .metric)
        XCTAssertEqual(celsiusValue, 20.0, accuracy: 0.001) // Allow for floating-point precision

        // Test converting from Celsius to Fahrenheit
        let celsiusValue2: Double = 20.0
        let fahrenheitValue2 = SummaryHelper.convertTempUnit(celsiusValue2, actualType: .metric, convertedType: .imperial)
        XCTAssertEqual(fahrenheitValue2, 68.0, accuracy: 0.001) // Allow for floating-point precision

        // Test converting between the same units (no conversion)
        let sameUnitsValue: Double = 30.0
        let unchangedValue = SummaryHelper.convertTempUnit(sameUnitsValue, actualType: .metric, convertedType: .metric)
        XCTAssertEqual(unchangedValue, 30.0, accuracy: 0.001) // Allow for floating-point precision
    }
    
}
