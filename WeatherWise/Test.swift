//
//  Test.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import Foundation
import SwiftUI

struct RecentWeatherListView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    var backgroundColor: Color = Color.init(uiColor: .systemGray6)
    
    var body: some View {
        CardRowView(title: "Card")
            .listRowBackground(backgroundColor)
            .listRowSeparator(.hidden)
    }
}


struct CardRowView: View {
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
            .fill(Color.white)
            .overlay(
                Text(title)
                    .font(.title)
                    .foregroundColor(.black)
            )
            .padding(.vertical, 8) // Add vertical padding between card views
            .shadow(radius: 5) // Add a shadow effect to create depth
            .padding(.vertical, 4) // Add extra vertical spacing between card views
    }
}

