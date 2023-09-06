//
//  HourlyView.swift
//  WeatherWise
//
//  Created by Runa Alam on 5/9/2023.
//

import SwiftUI

struct HourlyView: View {
    @State var hourlySummary: HourlySummary
    
    var body: some View {

        VStack(spacing: 16) {
            Text(hourlySummary.hourlyActualTemp)
                .font(.caption)
                .fontWeight(.medium)
            hourlySummary.hourlyIcon
                .imageScale(.large)
            Text(hourlySummary.currentTime)
                .font(.caption)
                .fontWeight(.medium)
                .layoutPriority(1)
                .fixedSize()
        }.padding(10)
            .background(Color.init(.secondarySystemBackground))
            .cornerRadius(10)
    }
}


struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let mockHourlyData = MockData.generateConsecutiveHourlySummaries()
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(mockHourlyData) { hourlySummary in
                    HourlyView(hourlySummary: hourlySummary)
                }
            }
        }
    }
}
