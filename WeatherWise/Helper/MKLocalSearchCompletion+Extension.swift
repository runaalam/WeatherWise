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
        let forbiddenTitle = ["St", "Rd", "Ave"]
        let forbiddenSubtitle = ["Search Nearby"]
        let commaCountSubtitle = subtitle.filter { $0 == "," }.count
        guard commaCountSubtitle < 2 else { return false }
        return !title.contains { $0.isNumber } &&
        !subtitle.contains { $0.isNumber } &&
        !forbiddenTitle.contains { title.contains($0) } &&
        !forbiddenSubtitle.contains { subtitle.contains($0) }
    }
}
