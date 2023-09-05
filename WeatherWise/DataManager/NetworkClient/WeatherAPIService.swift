//
//  WeatherAPIClient.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation
import Combine

public enum WeatherAPIRequest: Endpoint {
    case weather(cityName: String)
    case forecast(cityName: String)
    case onecall(lat: Double, lon: Double)
    
    var baseURL: String {
        return Constants.URL_BASE
    }
    
    var apiKey: String? {
        return  Constants.API_KEY
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .weather:
            return Constants.API_VERSION + Constants.URL_PATH_WEATHER
        case .forecast:
            return Constants.API_VERSION + Constants.URL_PATH_FORECAST
        case .onecall:
            return Constants.API_VERSION + Constants.URL_PATH_ONECALL
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .weather(let cityName), .forecast(let cityName):
            return [URLQueryItem(name: "q", value: cityName),
                    URLQueryItem(name: "units", value: UnitsService.selectedUnit.rawValue),
                    URLQueryItem(name: "appid", value: apiKey)]
        case .onecall(let lat, let lon):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        }
    }
}

struct WeatherAPIService: APIClient {
    static let shared = WeatherAPIService()
    
    // Method to fetch weather data by city name
    func getWeatherByCityPublisher(cityName: String) -> AnyPublisher<WeatherCurrentResponse, APIClientError> {
        let endpoint = WeatherAPIRequest.weather(cityName: cityName)
        print("End point \(endpoint)")
        return fetchDataPublisher(from: endpoint)
    }
    
    // Method to fetch forecast data by city name
    func getForecastByCityPublisher(city: String) -> AnyPublisher<WeatherForecastResponse, APIClientError> {
        let endpoint = WeatherAPIRequest.forecast(cityName: city)
        print("End point \(endpoint)")
        return fetchDataPublisher(from: endpoint)
    }
    
    // Method to fetch onecall data by coordinates
    func getOnecallPublisher(lat: Double, lon: Double) -> AnyPublisher<OneCallWeatherResponse, APIClientError> {
        let endpoint = WeatherAPIRequest.onecall(lat: lat, lon: lon)
        print("End point \(endpoint)")
        return fetchDataPublisher(from: endpoint)
    }
    
    private func decodeResponse<T: Decodable>(data: Data) -> AnyPublisher<T, APIClientError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return Just(decodedData)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIClientError.decodingFailed).eraseToAnyPublisher()
        }
    }
}

//struct WeatherAPIService: APIClient {
//    // fetching weather data by city name
//    func getWeatherByCity(cityName: String, completion: @escaping (Result<WeatherCurrentResponse, APIClientError>) -> Void) {
//        let endpoint = WeatherAPIRequest.weather(cityName: cityName)
//        self.fetchData(from: endpoint, completion: completion)
//    }
//
//    // fetching forecast data by city name
//    func getForecastByCity(city: String, completion: @escaping (Result<WeatherForecastResponse, APIClientError>) -> Void) {
//        let endpoint = WeatherAPIRequest.forecast(cityName: city)
//        self.fetchData(from: endpoint, completion: completion)
//    }
//
//    // fetching onecall data by coordinates
//    func getOnecall(lat: Double, lon: Double, completion: @escaping (Result<OneCallWeatherResponse, APIClientError>) -> Void) {
//        let endpoint = WeatherAPIRequest.onecall(lat: lat, lon: lon)
//        self.fetchData(from: endpoint, completion: completion)
//    }
//}

//switch endPoint {
//case .weather(let cityName):
//    self.path = endPoint.path
//    self.queryItems =  [
//        URLQueryItem(name: "q", value: cityName),
//        URLQueryItem(name: "appid", value: apiKey)
//    ]
//case .forecast(cityName: let cityName):
//    self.path = endPoint.path
//    self.queryItems =  [
//        URLQueryItem(name: "q", value: cityName),
//        URLQueryItem(name: "appid", value: apiKey)
//    ]
//case .onecall(let lat, let lon):
//    self.path = endPoint.path
//    self.queryItems =  [
//        URLQueryItem(name: "lat", value: "\(lat)"),
//        URLQueryItem(name: "lon", value: "\(lon)"),
//        URLQueryItem(name: "appid", value: apiKey)
//    ]
//}

//init(request: WeatherAPIRequest) {
//    self.path = request.path
//    var localQueryItems = request.queryItems ?? []
//        localQueryItems.append(URLQueryItem(name: "appid", value: apiKey))
//        self.queryItems = localQueryItems
//}
