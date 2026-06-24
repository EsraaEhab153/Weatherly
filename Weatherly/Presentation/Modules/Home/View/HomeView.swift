//
//  HomeView.swift
//  Weatherly
//
//  Created by Esraa Ehab on 18/06/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var locationMananger = LocationManager()
    var currentTimeOfDay : TimeOfDay {
        Date().timeOfDay
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image(currentTimeOfDay.backgroundImageName)
                    .resizable()
                    .ignoresSafeArea()
                
                if viewModel.isLoading || locationMananger.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(currentTimeOfDay.textColor)
                } else if let weather = viewModel.weather {
                    ScrollView {
                        VStack(spacing: 40) {
                            TopWeatherSection(location: weather.location, current: weather.current, todayForecast: weather.forecast.forecastday.first)
                            
                            MiddleWeatherSection(forecastDays: weather.forecast.forecastday)
                            
                            BottomStateSection(current: weather.current)
                            
                        }
                        .padding()
                    }
                    .safeAreaPadding(.bottom, 100)
                    .foregroundColor(currentTimeOfDay.textColor)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                //viewModel.fetchWeather(for: "Cairo")
                locationMananger.requsetLocation()
            }
            .onChange(of: locationMananger.location){ newLocation in
                if let location = newLocation{
                    let lat = location.coordinate.latitude
                    let lon = location.coordinate.longitude
                    viewModel.fetchWeather(for: "\(lat),\(lon)")
                }
                
            }
        }
        .tint(currentTimeOfDay.textColor)
    }
}

#Preview {
    HomeView()
}
