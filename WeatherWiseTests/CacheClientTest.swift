//
//  CacheClientTest.swift
//  WeatherWiseTests
//
//  Created by Runa Alam on 7/9/2023.
//

import XCTest

@testable import WeatherWise

class CacheClientTests: XCTestCase {
    
    var cacheClient: CacheClient!
    
    struct Person: Codable {
        let name: String
        let age: Int
    }
    
    override func setUp() {
        super.setUp()
        cacheClient = CacheClient.shared
        cacheClient.clearCache()
    }
    
    override func tearDown() {
        cacheClient.clearCache()
        cacheClient = nil
        super.tearDown()
    }
    
    func testSaveAndGetFromCache() {
        //test with different data to check generic method works for any object
        let person = Person(name: "John Doe", age: 30)
        cacheClient.saveToCache(person, forKey: "Person")
        
        let cachedPerson: Person? = cacheClient.getFromCache(forKey: "Person")
        
        XCTAssertNotNil(cachedPerson)
        XCTAssertEqual(cachedPerson?.name, "John Doe")
        XCTAssertEqual(cachedPerson?.age, 30)
    }
    
    func testRemoveFromCache() {
        let city = City(name: "Sydney", country: "Australia")
        
        cacheClient.saveToCache(city, forKey: "City")
        
        cacheClient.removeFromCache(forKey: "City")
        
        let cachedCity: City? = cacheClient.getFromCache(forKey: "City")
        
        XCTAssertNil(cachedCity)
    }
    
    func testClearCache() {
        let city = City(name: "Sydney", country: "Australia")
        cacheClient.saveToCache(city, forKey: "City")
        
        cacheClient.clearCache()
        
        let cachedCity: City? = cacheClient.getFromCache(forKey: "City")
        
        XCTAssertNil(cachedCity)
    }
    
    func testSaveCity() {
        let cityCacheService = CityCacheService.shared
        
        // Given sample city
        let city = City(name: "Dhaka", country: "Bangladesh")
        
        // Save the city to the cache
        cityCacheService.saveCity(city: city)
        
        // Retrieve all cities from the cache
        let cachedCities = cityCacheService.getAllCities()
        
        // Check if the saved city is in the cached cities
        XCTAssertTrue(cachedCities.contains { $0.name == city.name && $0.country == city.country })
    }
    
    func testDeleteCity() {
        let cityCacheService = CityCacheService.shared
        
        // Given sample city
        let city = City(name: "Denver", country: "United State")
        
        // Save the city to the cache
        cityCacheService.saveCity(city: city)
        
        // Delete the city from the cache
        cityCacheService.deleteCity(city: city)
        
        // Retrieve all cities from the cache
        let cachedCities = cityCacheService.getAllCities()
        
        // Check if the deleted city is not in the cached cities
        XCTAssertFalse(cachedCities.contains { $0.name == city.name && $0.country == city.country })
    }
}

