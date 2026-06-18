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
