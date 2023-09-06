//
//  CurrentView.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import SwiftUI

struct CurrentView: View {
    @State var currentSummary: CurrentSummary

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                VStack (alignment: .leading) {
                    detailView(text: currentSummary.sunriseTimeString,
                               image: .init(systemName: "sunrise"),
                               offset: .init(width: 0, height: -2))
                    detailView(text: currentSummary.sunsetTimeString,
                               image: .init(systemName: "sunset"),
                               offset: .init(width: 0, height: -2))
                }
                Spacer()
                VStack(alignment: .leading) {
                    detailView(text: "UV: \(currentSummary.uvIndex)",
                               image: .init(systemName: "sun.max"))
                    detailView(text: String(currentSummary.humidity),
                               image: .init(systemName: "thermometer.sun"))
                }
                Spacer()
                VStack(alignment: .leading) {
                    detailView(text: currentSummary.windSpeedString,
                               image: .init(systemName: "wind"))
                    detailView(text: currentSummary.windDirection,
                               image: .init(systemName: "arrow.up.right.circle"))
                }
            }
        }
    }
    
    private func detailView(text: String, image: Image, offset: CGSize = .zero) -> some View {
        HStack {
            image
                .imageScale(.medium)
                .foregroundColor(.blue)
                .offset(offset)
            Text(text)
        }
    }
}



struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView(currentSummary: MockData.getMockCurrentSummary())
        
    }
}
