//
//  WeatherlyApp.swift
//  Weatherly
//
//  Created by Esraa Ehab on 17/06/2026.
//

import SwiftUI
import SwiftData

@main
struct WeatherlyApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for:SavedLocations.self)
    }
}
