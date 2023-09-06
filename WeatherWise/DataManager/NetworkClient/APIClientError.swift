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
    case unknown(error: Error)
    case message(message: String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noDataReceived:
            return "No data received"
        case .decodingFailed:
            return "Decoding Fail"
        case .requestFailed:
            return "Request Fail"
        case .responseError:
            return "Response Error"
        case .unknown(let error):
            return error.localizedDescription
        case .message(let message):
            return message
        }
    }
}
