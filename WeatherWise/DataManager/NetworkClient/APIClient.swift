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
                .unknown(message: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { data, _ in
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in
                        .decodingFailed
                    }
            }
            .eraseToAnyPublisher()
    }
}

//protocol APIClient {
//    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void)
//}

//extension APIClient {
//    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void) {
//        guard let url = endpoint.url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.httpMethod.rawValue
//        request.setValue(Constants.HEADER_CONTENT_VALUE, forHTTPHeaderField: Constants.HEADER_CONTENT_KEY)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(.unknown(message: error.localizedDescription)))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noDataReceived))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let weatherResponse = try decoder.decode(T.self, from: data)
//                completion(.success(weatherResponse))
//            } catch {
//                completion(.failure(.decodingFailed))
//            }
//        }
//
//        task.resume()
//    }
//}
