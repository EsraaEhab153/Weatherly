//
//  WeatherModel.swift
//  Weatherly
//
//  Created by Esraa Ehab on 17/06/2026.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String?
    let country: String
    let localtime: String
}

struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let pressureMb: Double
    let humidity: Int
    let feelslikeC: Double
    let visKm: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case pressureMb = "pressure_mb"
        case humidity
        case feelslikeC = "feelslike_c"
        case visKm = "vis_km"
    }
}

struct Condition: Codable {
    let text: String
    let icon: String 
    let code: Int
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct Hour: Codable {
    let time: String
    let tempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}
