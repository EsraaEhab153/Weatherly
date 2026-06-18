//
//  WeatherNetworkManager.swift
//  Weatherly
//
//  Created by Esraa Ehab on 18/06/2026.
//

import Foundation

protocol WeatherNetworkService {
    func fetchWeather(for location: String, days: Int) async throws -> WeatherResponse
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class WeatherNetworkManager: WeatherNetworkService {
    
    func fetchWeather(for location: String, days: Int = 3) async throws -> WeatherResponse {
        let urlString = "\(Constants.baseURL)/forecast.json?key=\(Constants.apiKey)&q=\(location)&days=\(days)&aqi=no&alerts=no"
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}
