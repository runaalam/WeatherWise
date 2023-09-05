//
//  SettingsMenuView.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import SwiftUI


struct SettingsMenuView: View {
    @StateObject private var viewModel = SettingsMenuViewModel()
    
    var body: some View {
        Menu {
            
            Button(action: {
                viewModel.setUnit(.standard)
            }) {
                if viewModel.selectedUnit == .standard {
                    HStack {
                        Text(Units.standard.getUnitLabel())
                        Image(systemName: "checkmark")
                    }
                } else {
                    Text(Units.standard.getUnitLabel())
                }
            }
            
            Button(action: {
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
