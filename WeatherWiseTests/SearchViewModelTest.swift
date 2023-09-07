//
//  SearchViewModelTest.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 7/9/2023.
//

import XCTest
import Combine

@testable import WeatherWise

class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
    }

    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }


    // MARK: - Handle Tap Tests

    func testHandleTap_WithNonEmptySearchableText_ShouldGetWeather() {
        // Given
        let city = City(id: "1", name: "CityName", country: "CountryName")
        viewModel.searchableText = "CityName"
        
        // Create an expectation to wait for the async operation
        let expectation = XCTestExpectation(description: "Weather data fetched successfully.")
        
        // When
        viewModel.handleTap(city: city)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Add assertions to verify the expected behavior
            print(self.viewModel.showAlert)
            XCTAssertTrue(self.viewModel.showAlert)
            
            // Fulfill the expectation to indicate that the async operation has completed
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled or for a timeout
        wait(for: [expectation], timeout: 2.0)
    }


    // MARK: - Delete Search History Tests
    
    func testDeleteSearchHistory_ShouldRemoveItemsFromSearchHistory() {
        let searchHistory = MockData.getMockSearchHistory()
        let historyCount = searchHistory.count

        viewModel.searchHistory = searchHistory
        
        // City object from Seach history are store in cacheare caching as reference for 
        // When
        viewModel.deleteSearchHistory(at: IndexSet(integer: 0))
        
        // Then
        XCTAssertNotEqual(viewModel.searchHistory.count, historyCount)
    }

    // MARK: - Other Tests

    func testShowAlert_ShouldSetAlertMessageAndShowAlert() {
        // Given
        let message = "Test message"
        
        // When
        viewModel.showAlert(message: message)
        
        // Then
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, message)
    }
}
