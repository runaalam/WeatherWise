//
//  SettingsMenuViewModel.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation

class SettingsMenuViewModel: ObservableObject {
    @Published var selectedUnit: Units = UnitsService.selectedUnit
    
    func setUnit(_ unit: Units) {
        selectedUnit = unit
        UnitsService.setSelectedUnit(unit)
    }
}
