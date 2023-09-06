//
//  RecentSearchList.swift
//  WeatherWise
//
//  Created by Runa Alam on 6/9/2023.
//

import Foundation
import SwiftUI

struct SearchHistoryListView: View {
    @EnvironmentObject var viewModel: SearchViewModel

    var body: some View {
        List {
            ForEach(viewModel.searchHistory.indices, id: \.self) { index in
                let searchedItem = viewModel.searchHistory[index]
                let city = searchedItem.city // Get the City object separately
                NavigationLink(destination: WeatherSummaryView(viewModel: WeatherSummaryViewModel(city: city))) {
                    HistoryListRow(searchedItem: searchedItem)
                        .listRowSeparator(.hidden)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        viewModel.deleteSearchHistory(at: offsets)
    }
}

struct HistoryListRow: View {
    let searchedItem: SearchHistory
    
    var body: some View {
        HStack {
            Spacer()
            Text(searchedItem.city.name)
                .fontWeight(.medium)
            Spacer()
            
            Text(searchedItem.weatherDescription)
                .fontWeight(.light)
                .foregroundColor(.secondary)
            Spacer()
            Text(searchedItem.tempString)
            
            AssetsHelper.getWeatherIcon(weatherId: searchedItem.weatherIcon)
                .imageScale(.large)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}
