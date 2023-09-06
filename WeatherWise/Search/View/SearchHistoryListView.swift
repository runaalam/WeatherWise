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
        HStack{
            Text(searchedItem.cityName)
                .fontWeight(.medium)
            Spacer()
            
            Text(searchedItem.weatherDescription)
                .fontWeight(.light)
                .font(.system(size: 12))
            Spacer()
            Text(searchedItem.tempString)
            
            AssetsHelper.getWeatherIcon(weatherId: searchedItem.weatherIcon)
                .imageScale(.large)
                .foregroundColor(.secondary)
        }
    }
}

struct HistoryListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let mockHistory: SearchHistory = MockData.getSingleMockHistory()
            HistoryListRow(searchedItem: mockHistory)
        }
        
        
        Group {
            let historyList: [SearchHistory] = MockData.getMockSearchHistory()
            
            SearchHistoryListView()
                .environmentObject(SearchViewModel(searchHistory: historyList))
        }
    }
}

//struct SearchHistoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockHistory: [SearchHistory] = MockData.getMockSearchHistory()
//
//        SearchHistoryListView()
//            .environmentObject(SearchViewModel(searchHistory: mockHistory))
//    }
//}
