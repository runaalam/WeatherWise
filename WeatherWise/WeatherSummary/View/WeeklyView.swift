//
//  WeeklyView.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import SwiftUI

struct WeeklyView: View {
    @State var dailySummary: DailySummary
    
    var body: some View {
      HStack {
        Text(dailySummary.dayString)
          .fontWeight(.medium)
        Spacer()
          Text("\(dailySummary.maxTempString) / \(dailySummary.minTempString)")
          .fontWeight(.light)
          dailySummary.weatherDetails.first?.weatherIcon
          .imageScale(.large)
          .foregroundColor(.secondary)
      }.padding(.horizontal)
        .padding(.vertical, 22)
        .background(Color.init(.secondarySystemBackground))
        .cornerRadius(10)
    }
  }

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView(dailySummary: MockData.generateRandomDailySummary(forDate: Date()))
    }
}
