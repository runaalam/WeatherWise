//
//  WeatherAPIClient.swift
//  WeatherWise
//
//  Created by Runa Alam on 31/8/2023.
//

import Foundation

struct WeatherAPIClient: Endpoint, APIClient {
    var baseURL: String {
        return Constants.URL_BASE
    }
    
    var apiKey: String? {
        return  Constants.API_KEY
    }
    
    var httpMethod: HTTPMethod
    
    var path: String
    
    var queryItems: [URLQueryItem]?
    
    init(httpMethod: HTTPMethod = .get, requestPathType: RequestPathType) {
        self.httpMethod = httpMethod
        switch requestPathType {
        case .weather(let cityName):
            self.path = Constants.API_VERSION + Constants.URL_PATH_WEATHER
            self.queryItems =  [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        case .forecast(cityName: let cityName):
            self.path = Constants.API_VERSION + Constants.URL_PATH_FORECAST
            self.queryItems =  [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        case .onecall(let lat, let lon):
            self.path = Constants.API_VERSION + Constants.URL_PATH_ONECALL
            self.queryItems =  [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
        }
    }
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<T, APIClientError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue(Constants.HEADER_CONTENT_VALUE, forHTTPHeaderField: Constants.HEADER_CONTENT_KEY)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(message: error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(T.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }
}



