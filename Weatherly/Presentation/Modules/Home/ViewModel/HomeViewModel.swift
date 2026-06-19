//
//  HomeViewModel.swift
//  Weatherly
//
//  Created by Esraa Ehab on 18/06/2026.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService: WeatherNetworkService
    
    init(networkService: WeatherNetworkService = WeatherNetworkManager()) {
        self.networkService = networkService
    }
    
    func fetchWeather(for city: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                weather = try await networkService.fetchWeather(for: city, days: 3)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
