//
//  SearchView.swift
//  WeatherWise
//
//  Created by Runa Alam on 2/9/2023.
//

import SwiftUI

struct SearchView: View {
    
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
}

struct SearchBar: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @FocusState private var isFocusedTextField: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(.systemBackground))
                .frame(height: 40)
                .padding(.all)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                
                TextField("Search By City", text: $viewModel.searchableText)
                    .font(.title)
                    .focused($isFocusedTextField)
                    .onReceive(
                        viewModel.$searchableText.debounce(
                            for: .seconds(1),
                            scheduler: DispatchQueue.main
                        )
                    ) {
                        viewModel.searchCity($0)
                    }
                    .overlay {
                        ClearButton(text: $viewModel.searchableText)
                            .padding(.trailing, 20)
                    }
                    .onAppear {
                        isFocusedTextField = true
                    }
            }
            
        }
        .onAppear {
            isFocusedTextField = true
        }
    }
}

struct SearchListView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
    
    var body: some View {
        List(self.viewModel.searchResults) { city in
            SearchListRow(searchResult: city)
                .listRowBackground(backgroundColor)
                .onTapGesture {
                    viewModel.handleTap(city: city)
                    viewModel.searchableText = ""
                }
        }
        .listStyle(.insetGrouped)
    }
}

struct SearchListRow: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    let searchResult: City
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(searchResult.name)
            Text(searchResult.country)
                .font(.caption)
        }
    }
}

struct NoMatchFoundView: View {
    @State var isShowingNoMatch: Bool
    
    var body: some View {
        if isShowingNoMatch {
            VStack {
                Spacer()
                Text("No Match Found")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct ClearButton: View {
    
    @Binding var text: String
    
    var body: some View {
        if text.isEmpty == false {
            HStack {
                Spacer()
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .foregroundColor(.secondary)
            }
        } else {
            EmptyView()
        }
    }
}

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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        Group {
            let history = MockData.getMockSearchHistory()
            let vm = SearchViewModel(searchHistory: history)
            SearchView(viewModel: vm)
        }
        .previewDisplayName("Weather")
        
    }
}

