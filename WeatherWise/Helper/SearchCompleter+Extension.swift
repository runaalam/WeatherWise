//
//  MKLocalSearchCompleter+Extension.swift
//  WeatherWise
//
//  Created by Runa Alam on 4/9/2023.
//

import Foundation
import MapKit

extension MKLocalSearchCompleter {
    func filterResults(excludedKeywords: [String]) -> [MKLocalSearchCompletion] {
        let filteredResults = results.filter { result in
            // Check if neither title nor subtitle contains any excluded keyword
            let isExcluded = excludedKeywords.contains { keyword in
                result.title.localizedCaseInsensitiveContains(keyword) ||
                result.subtitle.localizedCaseInsensitiveContains(keyword)
            }
            
            // Check if neither title nor subtitle contains numbers
            let containsNumbers = result.title.rangeOfCharacter(from: .decimalDigits) != nil ||
                result.subtitle.rangeOfCharacter(from: .decimalDigits) != nil
            
            return !isExcluded && !containsNumbers
        }
        return filteredResults
    }
}
