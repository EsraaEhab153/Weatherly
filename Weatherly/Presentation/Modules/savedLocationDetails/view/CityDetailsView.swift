//
//  CityDetailsView.swift
//  Weatherly
//
//  Created by Esraa Ehab on 24/06/2026.
//

import SwiftUI

struct CityDetailsView: View {
    let cityName: String
    
    @StateObject private var viewModel = HomeViewModel()
    
    var currentTimeOfDay: TimeOfDay {
        Date().timeOfDay
    }
    
    var body: some View {
        ZStack {
            Image(currentTimeOfDay.backgroundImageName)
                .resizable()
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading \(cityName)...")
                    .tint(currentTimeOfDay.textColor)
                    .foregroundColor(currentTimeOfDay.textColor)
            } else if let weather = viewModel.weather {
                ScrollView {
                    VStack(spacing: 20) {
                        TopWeatherSection(location: weather.location, current: weather.current, todayForecast: weather.forecast.forecastday.first)
                        
                        MiddleWeatherSection(forecastDays: weather.forecast.forecastday)
                        
                        BottomStateSection(current: weather.current)
                    }
                    .padding(.top)
                }
                .safeAreaPadding(.bottom, 100)
                .foregroundColor(currentTimeOfDay.textColor)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .task {
            await viewModel.fetchWeather(for: cityName)
        }
    }
}
