//
//  WeatherSummaryViewModel.swift
//  WeatherWise
//
//  Created by Runa Alam on 6/9/2023.
//

import Foundation
import Combine
import SwiftUI

class WeatherSummaryViewModel: ObservableObject {
    @Published private(set) var weatherSummary: WeatherSummary
    @State private var refreshView = false
    
    private let city: City
    private let weatherService = WeatherAPIService()
    private var cancellable = Set<AnyCancellable>()
       
    var cityName: String {
        SummaryHelper.removeAfterComma(city.name)
    }
    
    init(city: City, weatherSummary: WeatherSummary = WeatherSummary()) {
        self.city = city
        self.weatherSummary = WeatherSummary(latitude: 0,
                                             longitude: 0,
                                             timezone: "",
                                             current: CurrentSummary(),
                                             daily: [],
                                             hourly: [])
    }
    
    func fetchWeatherSummary() {
        let coordinate = city.coordinate
        weatherService.getOnecallPublisher(lat: coordinate.lat, lon: coordinate.lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Fetching onecall weather data")
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.weatherSummary = WeatherSummary(latitude: response.lat,
                                                      longitude: response.lon,
                                                      timezone: response.timezone,
                                                      current: CurrentSummary(response: response.current),
                                                      daily: response.daily.map { DailySummary(response: $0) },
                                                      hourly: response.hourly.map { HourlySummary(response: $0)}
                )
            })
            .store(in: &cancellable)
    }
}
