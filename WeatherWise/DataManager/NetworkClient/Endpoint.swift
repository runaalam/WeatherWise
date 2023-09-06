//
//  Endpoints.swift
//  WeatherWise
//
//  Created by Runa Alam on 30/8/2023.
//

import Foundation

// Protocol defining the structure of an API endpoint.
protocol Endpoint {
    var baseURL: String { get }             // The base URL of the API.
    var apiKey: String? { get }             // Optional API key (if required).
    var path: String { get }                // The path for the specific endpoint.
    var httpMethod: HTTPMethod { get }      // The HTTP method for the request.
    var queryItems: [URLQueryItem]? { get } // Optional query parameters for the request.
    
}

// Extension for the Endpoint protocol providing a computed property for generating the full URL.
extension Endpoint {
    var url: URL? {
        var components = URLComponents(string: baseURL) // Create URL components.
        components?.path = path                         // Set the path.
        components?.queryItems = queryItems             // Set optional query parameters.
        return components?.url                          // Assemble the full URL.
    }
}

// Enum defining HTTP methods as string values.
public enum HTTPMethod: String {
    case get = "GET"      // HTTP GET method.
    case post = "POST"    // HTTP POST method.
    case put = "PUT"      // HTTP PUT method.
    case delete = "DELETE"// HTTP DELETE method.
}

