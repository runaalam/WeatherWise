//
//  APIClient.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation
import Combine

// Protocol defining the interface for an API client.
protocol APIClient {
    // Asynchronous method to fetch data from an endpoint using Combine and return a publisher.
    func fetchDataPublisher<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, APIClientError>
    
    // Asynchronous method to fetch data from an endpoint and invoke a completion handler.
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void)
}

extension APIClient {
    // Default implementation of the fetchDataPublisher method.
    func fetchDataPublisher<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, APIClientError> {
        // Ensure the URL is valid; otherwise, return a failure publisher.
        guard let url = endpoint.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        print("URL: \(url)")
        
        // Create an HTTP request with the specified HTTP method and headers.
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue(Constants.HEADER_CONTENT_VALUE, forHTTPHeaderField: Constants.HEADER_CONTENT_KEY)
        
        // Use URLSession and Combine to send the request and decode the response.
        return URLSession.shared.dataTaskPublisher(for: request)
        // Map URLSession errors to custom APIClientError values.
            .mapError { error in
                    .requestFailed
            }
            .flatMap(maxPublishers: .max(1)) { data, _ in
                // Decode the received data into the specified generic type.
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        // Map decoding errors to custom APIClientError values.
                        return .unknown(error: error)
                    }
            }
            .eraseToAnyPublisher()
    }
    
    // Default implementation of the fetchData method.
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void) {
        // Ensure the URL is valid; otherwise, invoke the completion handler with an error.
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Create an HTTP request with the specified HTTP method and headers.
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue(Constants.HEADER_CONTENT_VALUE, forHTTPHeaderField: Constants.HEADER_CONTENT_KEY)
        
        // Use URLSession to send the request and handle the response.
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // If there is a network or request error, invoke the completion handler with an error.
                completion(.failure(.unknown(error: error)))
                return
            }
            
            guard let data = data else {
                // If no data is received, invoke the completion handler with a no data error.
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                // Decode the received data into the specified generic type and invoke the completion handler with the result.
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                // If decoding fails, invoke the completion handler with a decoding error.
                completion(.failure(.decodingFailed))
            }
        }.resume() // Start the URLSession data task.
    }
}

