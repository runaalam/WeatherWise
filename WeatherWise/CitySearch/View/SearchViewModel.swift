//
//  SearchViewModel.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation
import MapKit
import Combine

class SearchViewModel: NSObject, ObservableObject {
    
    @Published private(set) var searchResults: Array<City> = []
    @Published var searchHistory: Array<SearchHistory> = []
    @Published var searchableText = ""
    @Published var selectedCity: City?
    @Published var isShowingNoMatch: Bool = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    /// Array to track deleted invoices
    var deletedHistory: [SearchHistory] = []
    
    private let weatherService = WeatherAPIService()
    private var cancellable = Set<AnyCancellable>()
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    init(searchHistory: [SearchHistory] = []) {
        self.searchHistory = searchHistory
    }
    
    func searchCity(_ searchableText: String) {
        if searchableText.isEmpty {
            searchResults = []
        } else {
            localSearchCompleter.queryFragment = searchableText
        }
    }
    
    func handleTap(city: City) {
        if !searchableText.isEmpty {
            getWeatherByCityName(city: city)
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    private func getWeatherByCityName(city: City) {
        weatherService.getWeatherByCityPublisher(cityName: SummaryHelper.removeAfterComma(city.name))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("Weather data fetched successfully.")
                case .failure(_):
                    self.showAlert = true
                    self.alertMessage = "City name is not found"
                }
            }, receiveValue: { weatherData in
                let coordinate = Coordinate(lon: weatherData.coord.lon, lat: weatherData.coord.lat)
                let city = City(id: city.id, name: city.name, country: city.country, coordinate: coordinate)
                
                if !CityCacheService.shared.isCityExist(city: city) {
                    CityCacheService.shared.saveCity(city: city)
                    let history = SearchHistory(city: city, response: weatherData)
                    self.searchHistory.append(history)
                }
            })
            .store(in: &cancellable)
    }
    
    func deleteSearchHistory(at offsets: IndexSet) {
        searchHistory.remove(atOffsets: offsets)
        let cities: [City] = searchHistory.map { $0.city }

        CityCacheService.shared.saveAllCities(cities: cities)
    }
}

extension SearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        Task { @MainActor in
            searchResults = completer.results.filter {
                !$0.title.contains("-") &&
                !$0.title.contains(where: \.isNumber) &&
                !$0.subtitle.contains(where: \.isNumber) &&
                !$0.subtitle.contains("Nearby") &&
                !$0.title.contains("Airport") &&
                !$0.title.contains("Tunnel") &&
                !$0.title.contains("Terminal") &&
                !$0.title.contains("Collage") &&
                !$0.title.contains("St") &&
                !$0.title.contains("Rd") &&
                !$0.title.contains("Ave")
            }
            .compactMap { result in
                return City(name: result.title,
                            country: result.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Completer Error")
        print(error)
    }
}


