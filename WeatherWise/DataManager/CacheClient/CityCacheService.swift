//
//  CityCacheService.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

class CityCacheService {

    // Shared instance of the CityService
    static let shared = CityCacheService()
    
    // The key name to use for storing cities in the cache
    let cityCacheKey = "cities"
    
    // MARK: - Save in cache
    // Saves an City to the cache.
    // If an city with the same name and country, it is replaced.
    func saveCity(city: City) {
        //Fetch all city
        var cities = getAllCities()
        
        if !cities.isEmpty {
            print("Cache is empty")
            CacheClient.shared.saveToCache(city, forKey: cityCacheKey)
        } else if !isCityExist(city: city) {
            // Add the new city to the array
            print("Cache is not exist")
            cities.append(city)
            CacheClient.shared.saveToCache(cities, forKey: cityCacheKey)
        }
    }
    
    // Saves an array of cities to the cache.
    func saveAllCities(cities: [City]) {
        //Delete previous city list and save updated city list
        deleteAllCities()
        CacheClient.shared.saveToCache(cities, forKey: cityCacheKey)
    }
   
    // MARK: - Delete from cache
    // Delete an city from the cache.
    func deleteCity(city: City) {
        var cities = getAllCities()
        
        if let index = cities.firstIndex(where: { $0.name == city.name && $0.country == city.country }) {
            cities.remove(at: index)
            CacheClient.shared.saveToCache(cities, forKey: cityCacheKey)
        }
    }
    
    // Deletes all Cities from the cache.
    func deleteAllCities() {
        CacheClient.shared.removeFromCache(forKey: cityCacheKey)
    }
    
    //MARK: - Fetch from cache
    // Retrieves all Cities from the cache.
    // Returns an array of City objects.
    func getAllCities() -> [City] {
        var cities: [City] = []
        
        if let cachedData = CacheClient.shared.cache.object(forKey: cityCacheKey as NSString) as? Data {
            do {
                let decoder = JSONDecoder()
                let decodedCities = try decoder.decode([City].self, from: cachedData)
                for city in decodedCities  {
                    cities.append(city)
                }
                
            } catch {
                print("Got Error ")
            }
        }
        return cities
    }
    
    func isCityExist(city: City) -> Bool {
        let cities = getAllCities()
        return cities.contains { $0.name == city.name && $0.country == city.country }
    }
}
