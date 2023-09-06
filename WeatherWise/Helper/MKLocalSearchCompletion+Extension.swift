//
//  MKSearchCompletre.swift
//  WeatherWise
//
//  Created by Runa Alam on 6/9/2023.
//

import Foundation
import MapKit

extension MKLocalSearchCompletion {
    var isValidCityResult: Bool {
        let forbiddenKeywords = ["-", "Nearby", "Airport", "Tunnel", "Terminal", "Collage", "St", "Rd", "Ave"]
        return !title.contains { $0.isNumber } &&
        !subtitle.contains { $0.isNumber } &&
        !forbiddenKeywords.contains { title.contains($0)
        }
    }
}
