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
        XCTAssertEqual(SummaryHelper.formatTemperature(25, unit: Units.metric), "25°C")
        XCTAssertEqual(SummaryHelper.formatTemperature(72.0, unit: Units.standard), "72°F")
        XCTAssertEqual(SummaryHelper.formatTemperature(nil, unit: Units.standard), "--º")
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
    
}
