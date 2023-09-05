//
//  Endpoints.swift
//  WeatherWise
//
//  Created by Runa Alam on 30/8/2023.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var apiKey: String? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get}
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

