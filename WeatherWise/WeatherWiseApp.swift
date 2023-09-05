//
//  WeatherWiseApp.swift
//  WeatherWise
//
//  Created by Runa Alam on 30/8/2023.
//

import SwiftUI

@main
struct WeatherWiseApp: App {
    var body: some Scene {
        WindowGroup {
            
//            SearchHistoryListView(viewModel: SearchHistoryViewModel())
//            SearchView(viewModel: SearchViewModel(searchHistoryViewModel: SearchHistoryViewModel()))
            SearchView(viewModel: SearchViewModel())
        }
    }
}
