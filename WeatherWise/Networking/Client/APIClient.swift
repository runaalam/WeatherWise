//
//  APIClient.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

protocol APIClient {
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void)
}

enum APIClientError: Error {
    case invalidURL
    case noDataReceived
    case decodingFailed
    case responseError
    case unknown(message: String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noDataReceived:
            return "Rqquest Fail"
        case .decodingFailed:
            return "Decoding Fail"
        case .responseError:
            return "Response Error"
        case .unknown(let message):
            return message
        }
    }
}
