//
//  WeatherSummaryViewModelTest.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 7/9/2023.
//

import XCTest
import Combine

@testable import WeatherWise

class WeatherSummaryViewModelTests: XCTestCase {
    var viewModel: WeatherSummaryViewModel!
    var cancellables: Set<AnyCancellable> = []
    let city = City(name: "Sydney", country: "Australia", coordinate: Coordinate(lon: 151.2093, lat: -33.8688))
    
    override func setUp() {
        super.setUp()
        viewModel = WeatherSummaryViewModel(city: city)
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }
    
    func testFetchWeatherSummary_ShouldFetchSummary() {
        // Given
        let expectation = XCTestExpectation(description: "Weather summary fetched")
        
        // When
        viewModel.fetchWeatherSummary()
        
        // Then
        viewModel.$weatherSummary
            .receive(on: DispatchQueue.global())
            .sink { [weak self] weatherSummary in
                if weatherSummary.latitude == self?.city.coordinate.lat && weatherSummary.longitude == self?.city.coordinate.lon {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
