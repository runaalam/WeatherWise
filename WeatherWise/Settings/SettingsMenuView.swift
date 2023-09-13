//
//  SettingsMenuView.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import SwiftUI


struct SettingsMenuView: View {
    @StateObject private var viewModel = SettingsMenuViewModel()
    @Binding var selectedUnit: Units
    
    var body: some View {
        Menu {
            
            Button(action: {
                selectedUnit = .imperial
                viewModel.setUnit(.imperial)
            }) {
                if viewModel.selectedUnit == .imperial {
                    HStack {
                        Text(Units.imperial.getUnitLabel())
                        Image(systemName: "checkmark")
                    }
                } else {
                    Text(Units.imperial.getUnitLabel())
                }
            }
            
            Button(action: {
                selectedUnit = .metric
                viewModel.setUnit(.metric)
            }) {
                if viewModel.selectedUnit == .metric {
                    HStack {
                        Text(Units.metric.getUnitLabel())
                        Image(systemName: "checkmark")
                    }
                } else {
                    Text(Units.metric.getUnitLabel())
                }
            }
           
        } label: {
            Image(systemName: "gear.circle")
        }
    }
}
