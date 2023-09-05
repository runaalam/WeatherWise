//
//  APIClientError.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

enum APIClientError: Error {
    case invalidURL
    case noDataReceived
    case decodingFailed
    case requestFailed
    case responseError
    case unknown(message: String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noDataReceived:
            return "Request Fail"
        case .decodingFailed:
            return "Decoding Fail"
        case .requestFailed:
            return "Request Fail"
        case .responseError:
            return "Response Error"
        case .unknown(let message):
            return message
        }
    }
}
