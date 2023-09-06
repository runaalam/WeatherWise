//
//  SearchBar.swift
//  WeatherWise
//
//  Created by Runa Alam on 6/9/2023.
//

import Foundation
import SwiftUI

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
