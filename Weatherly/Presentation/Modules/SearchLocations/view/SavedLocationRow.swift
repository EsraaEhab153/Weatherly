//
//  SavedLocationRow.swift
//  Weatherly
//
//  Created by Esraa Ehab on 23/06/2026.
//

import SwiftUI

struct SavedLocationRow: View {
    let location: SavedLocations
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isLoading = false
    private let networkManager = WeatherNetworkManager()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(location.name)
                    .font(.headline)
                Text(location.country)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if let iconUrl = location.iconUrl, let max = location.maxTemp, let min = location.minTemp {
                HStack(spacing: 15) {
                    AsyncImage(url: URL(string: "https:\(iconUrl)")) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 40, height: 40)
                    
                    VStack(alignment: .trailing) {
                        Text("\(Int(max))°")
                            .font(.body)
                            .bold()
                        Text("\(Int(min))°")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            else if isLoading {
                ProgressView()
            }
        }
        .padding(.vertical, 5)
        .task {
            await updateWeatherIfNeeded()
        }
    }
    
    private func updateWeatherIfNeeded() async {
        if location.maxTemp == nil {
            isLoading = true
        }
        
        do {
            let query = "\(location.lat),\(location.lon)"
            let weather = try await networkManager.fetchWeather(for: query)
            
            if let today = weather.forecast.forecastday.first {
                location.maxTemp = today.day.maxtempC
                location.minTemp = today.day.mintempC
                location.iconUrl = weather.current.condition.icon
                
                try? modelContext.save()
            }
            isLoading = false
        } catch {
            print("Offline or Error fetching row weather: \(error.localizedDescription)")
            isLoading = false
        }
    }
}
