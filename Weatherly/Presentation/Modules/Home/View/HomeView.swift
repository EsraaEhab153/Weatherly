//
//  HomeView.swift
//  Weatherly
//
//  Created by Esraa Ehab on 18/06/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var currentTimeOfDay : TimeOfDay {
        Date().timeOfDay
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image(currentTimeOfDay.backgroundImageName)
                    .resizable()
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(currentTimeOfDay.textColor)
                } else if let weather = viewModel.weather {
                    ScrollView {
                        VStack(spacing: 40) {
                            TopWeatherSection(location: weather.location, current: weather.current, todayForecast: weather.forecast.forecastday.first)
                            
                        }
                        .padding()
                    }
                    .foregroundColor(currentTimeOfDay.textColor)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                viewModel.fetchWeather(for: "Cairo")
            }
        }
    }
}

#Preview {
    HomeView()
}
