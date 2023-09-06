//
//  APIClient.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

import Foundation
import Combine

protocol APIClient {
    func fetchDataPublisher<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, APIClientError>
}

extension APIClient {
    func fetchDataPublisher<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, APIClientError> {
        guard let url = endpoint.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        print("URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue(Constants.HEADER_CONTENT_VALUE, forHTTPHeaderField: Constants.HEADER_CONTENT_KEY)

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                    .requestFailed
            }
            .flatMap(maxPublishers: .max(1)) { data, _ in
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        return .unknown(error: error)
                    }
            }
            .eraseToAnyPublisher()
    }
}

