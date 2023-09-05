//
//  CacheClient.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

protocol CacheClientProtocol {
    // Saves the provided object to the cache with the specified key.
    // The object must conform to the Codable protocol.
    func saveToCache<T: Codable>(_ object: T, forKey key: String)
    
    // Retrieves an object from the cache with the specified key.
    // The object type must conform to the Codable protocol.
    func getFromCache<T: Codable>(forKey key: String) -> T?
    
    // Removes an object from the cache with the specified key.
    func removeFromCache(forKey key: String)
    
    // Clears the entire cache, removing all objects.
    func clearCache()
}

class CacheClient: CacheClientProtocol {
   
    // Shared instance of the cache client
    static let shared = CacheClient()
    
    // The underlying cache object
    public let cache = NSCache<NSString, AnyObject>()
    
    // Initialises a new instance of the CacheClient.
    public init() {}
    
    // Saves the provided object to the cache with the specified key.
    // The object must conform to the Codable protocol.
    func saveToCache<T: Codable>(_ object: T, forKey key: String) {
        let data = try? JSONEncoder().encode(object)
        cache.setObject(data as AnyObject, forKey: key as NSString)
        print("Saved city successfully")
    }
    
    // Retrieves an object from the cache with the specified key.
    // The object type must conform to the Codable protocol.
    func getFromCache<T: Codable>(forKey key: String) -> T? {
        if let cachedData = cache.object(forKey: key as NSString) as? Data {
            let object = try? JSONDecoder().decode(T.self, from: cachedData)
            return object
        }
        return nil
    }
    
    // Removes an object from the cache with the specified key.
    func removeFromCache(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    // Clears the entire cache, removing all objects.
    func clearCache() {
        cache.removeAllObjects()
    }
}
