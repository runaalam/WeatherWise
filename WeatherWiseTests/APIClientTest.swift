//
//  APIClientTest.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 7/9/2023.
//


import XCTest
import Combine

@testable import WeatherWise
// Define a test data model for the API response
struct TestResponseModel: Decodable {
    let message: String
}

class MockAPIClient: APIClient {
    var shouldSucceed: Bool = true
    var responseDelay: TimeInterval = 0 // Optional delay to simulate network latency
    
    func fetchDataPublisher<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, APIClientError> {
        return Future<T, APIClientError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + self.responseDelay) {
                if self.shouldSucceed {
                    let testResponse = TestResponseModel(message: "Mock API Response")
                    promise(.success(testResponse as! T))
                } else {
                    promise(.failure(.requestFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void) {
        if shouldSucceed {
            let testResponse = TestResponseModel(message: "Mock API Response")
            completion(.success(testResponse as! T))
        } else {
            completion(.failure(.requestFailed))
        }
    }
}

class APIClientTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    var mockAPIClientSuccess: MockAPIClient {
        let mockClient = MockAPIClient()
        mockClient.shouldSucceed = true
        return mockClient
    }
    
    var mockAPIClientFailure: MockAPIClient {
        let mockClient = MockAPIClient()
        mockClient.shouldSucceed = false
        return mockClient
    }
    
    func testFetchDataPublisherSuccess() {
            let expectation = XCTestExpectation(description: "Fetch Data Publisher Success")
            
            let endpoint = TestEndpoint()
            
            // Call fetchDataPublisher with the mock API client (success scenario)
            mockAPIClientSuccess.fetchDataPublisher(from: endpoint)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break // Success
                    case .failure(let error):
                        XCTFail("Expected success but received error: \(error)")
                    }
                    expectation.fulfill()
                }, receiveValue: { (response: TestResponseModel) in
                    // Verify the response here
                    XCTAssertEqual(response.message, "Mock API Response")
                })
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        }
    
    func testFetchDataPublisherFailure() {
        let expectation = XCTestExpectation(description: "Fetch Data Publisher Failure")
        
        
        let endpoint = TestEndpoint()
        
        // Call fetchDataPublisher with the mock API client (failure scenario)
        mockAPIClientFailure.fetchDataPublisher(from: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure but received success")
                case .failure(let error):
                    // Verify the error type here
                    XCTAssertEqual(error, .requestFailed)
                }
                expectation.fulfill()
            }, receiveValue: { (_: TestResponseModel) in
                XCTFail("Expected failure but received a value")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Define a test endpoint conforming to the Endpoint protocol
struct TestEndpoint: Endpoint {
    var baseURL: String {
        return "https://example.com"
    }
    
    var apiKey: String? {
        return nil
    }
    
    var path: String {
        return "/test"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}

