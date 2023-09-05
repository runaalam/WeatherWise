////
////  SettingsView.swift
////  WeatherWise
////
////  Created by Runa Alam on 5/9/2023.
////
//
//import SwiftUI
//
//struct SettingsView: View {
//    @State private var selectedUnit: Units = UnitsService.selectedUnit
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form {
//                    Section(header: Text("Units")) {
//                        Picker("Select Unit", selection: $selectedUnit) {
//                            Text("Fahrenheit").tag(Units.standard)
//                            Text("Celsius").tag(Units.metric)
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                    }
//                }
//            }
//            .navigationTitle("Settings")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        // Save the selected unit to UserDefaults
//                        UnitsService.setSelectedUnit(selectedUnit)
//                    }) {
//                        Text("Save")
//                    }
//                }
//            }
//        }
//    }
//}
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
