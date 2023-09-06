//
//  WeatherSummaryView.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import SwiftUI

struct WeatherSummaryView: View {
    @StateObject var viewModel: WeatherSummaryViewModel

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                HStack {
                    VStack(spacing: 4) {
                        Text(viewModel.cityName)
                            .font(.system(size: 30))
                        Text(viewModel.weatherSummary.currentTempDescription)
                            .font(.headline)
                            .fontWeight(.medium)
                        HStack {
                            viewModel.weatherSummary.current.weatherDetails.first?.weatherIcon
                                .imageScale(.small)
                            Text("\(viewModel.weatherSummary.current.currentTempString)")
                                .fontWeight(.semibold)
                        }.font(.system(size: 40))
                            .frame(maxWidth: .infinity)
                        HStack(spacing: 16) {
                            Text("Feels like \(viewModel.weatherSummary.current.feelsLikeTempFormatter)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                CurrentView(currentSummary: viewModel.weatherSummary.current)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.weatherSummary.hourly) { hourlySummary in
                            HourlyView(hourlySummary: hourlySummary)
                        }
                    }
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.weatherSummary.daily) { dailySummary in
                            WeeklyView(dailySummary: dailySummary)
                        }
                    }
                }
            }.padding([.horizontal])
                .padding(.top)
        }
        .onAppear {
            viewModel.fetchWeatherSummary()
        }
    }
}

struct WeatherSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSummaryView(viewModel: WeatherSummaryViewModel(city: MockData.getMockCity()))
    }
}
