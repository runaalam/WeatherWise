//
//  SearchView.swift
//  WeatherWise
//
//  Created by Runa Alam on 2/9/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: SearchViewModel

    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBar()
                    .environmentObject(viewModel)
                    .padding(.top, 20)
                ZStack(alignment: .top) {
                    SearchHistoryListView()
                        .environmentObject(viewModel)
                    if !viewModel.searchableText.isEmpty {
                        SearchListView()
                            .environmentObject(viewModel)
                    }
                }
            }
            .background(backgroundColor)
            .navigationTitle("Weather")
            .navigationBarItems(trailing: SettingsMenuView())
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(""),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK")) {
                        viewModel.showAlert = false
                    }
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        Group {
            let history = MockData.getMockSearchHistory()
            let vm = SearchViewModel(searchHistory: history)
            MainView(viewModel: vm)
        }
        .previewDisplayName("Weather")
        
    }
}

