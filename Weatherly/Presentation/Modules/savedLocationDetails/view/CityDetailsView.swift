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
    
    var cityTimeOfDay: TimeOfDay {
            return viewModel.weather?.location.localtime.toCityTimeOfDay() ?? Date().timeOfDay
        }
    
    var body: some View {
        ZStack {
            Image(cityTimeOfDay.backgroundImageName)
                .resizable()
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading \(cityName)...")
                    .tint(cityTimeOfDay.textColor)
                    .foregroundColor(cityTimeOfDay.textColor)
            } else if let weather = viewModel.weather {
                ScrollView {
                    VStack(spacing: 20) {
                        TopWeatherSection(location: weather.location, current: weather.current, todayForecast: weather.forecast.forecastday.first)
                        
                        MiddleWeatherSection(forecastDays: weather.forecast.forecastday, timeOfDay: cityTimeOfDay)
                        
                        BottomStateSection(current: weather.current)
                    }
                    .padding(.top)
                }
                .safeAreaPadding(.bottom, 100)
                .foregroundColor(cityTimeOfDay.textColor)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .task {
            await viewModel.fetchWeather(for: cityName)
        }
    }
}
