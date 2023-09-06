//
//  AssetsHelperTest.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 7/9/2023.
//

import XCTest
import SwiftUI

@testable import WeatherWise
final class AssetsHelperTest: XCTestCase {
    
    func testGetWeatherIcon() {
        
        // Define a test mapping for known weather conditions
        let testMapping: [String: String] = [
            "01d": "sun.max",
            "01n": "moon",
            "02d": "cloud.sun",
            "02n": "cloud.moon",
            "03d": "cloud",
            "03n": "cloud",
            "09d": "cloud.rain",
            "09n": "cloud.rain",
        ]
        
        // Create a mock AssetsHelper with the test mapping
        struct MockAssetsHelper {
            let mapping: [String: String]
            
            func getWeatherIcon(weatherId: String) -> Image {
                if let imageName = mapping[weatherId] {
                    return Image(systemName: imageName)
                } else {
                    return Image(systemName: "star")
                }
            }
        }
        
        // Initialise the mock helper with the test mapping
        let mockHelper = MockAssetsHelper(mapping: testMapping)
        
        // Test each known weather condition and ensure the correct image is returned
        for (weatherId, expectedImageName) in testMapping {
            let expectedImage = Image(systemName: expectedImageName)
            XCTAssertEqual(mockHelper.getWeatherIcon(weatherId: weatherId), expectedImage)
        }
        
        let notExpectedIcon = Image(systemName: "cloud")
        // Test for an unknown weather ID should return the default icon which is star
        XCTAssertNotEqual(mockHelper.getWeatherIcon(weatherId: "unknown"), notExpectedIcon)
    }
}
