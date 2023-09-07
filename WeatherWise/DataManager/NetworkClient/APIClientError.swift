//
//  APIClientError.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

enum APIClientError: Error, Equatable {
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
    
    static func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noDataReceived, .noDataReceived),
             (.decodingFailed, .decodingFailed),
             (.requestFailed, .requestFailed),
             (.responseError, .responseError):
            return true
        case let (.unknown(error1), .unknown(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case let (.message(message1), .message(message2)):
            return message1 == message2
        default:
            return false
        }
    }
}
