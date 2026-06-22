//
//  MiddleWeatherSection.swift
//  Weatherly
//
//  Created by Esraa Ehab on 19/06/2026.
//

import SwiftUI

struct MiddleWeatherSection: View {
    
    let forecastDays: [ForecastDay]
    
    var body: some View {
        VStack{
            Text("3-DAY FORECAST")
                .font(.subheadline)
                .opacity(0.8)
            
            Divider()
            
            ForEach(forecastDays, id: \.date) { day in
                NavigationLink(destination: HourlyForecastView(hours: day.hour,dateString: day.date)) {
                    HStack {
                        Text(day.date.toDayName())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 30, height: 30)
                        Text("\(day.day.mintempC, specifier: "%.1f")° - \(day.day.maxtempC, specifier: "%.1f")°")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Divider()
            }
        }
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(15)
    }
}
