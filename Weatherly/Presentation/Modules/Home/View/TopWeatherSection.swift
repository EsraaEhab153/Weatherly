//
//  TopWeatherSection.swift
//  Weatherly
//
//  Created by Esraa Ehab on 19/06/2026.
//

import SwiftUI

struct TopWeatherSection: View {
    
 
    
    let location : Location
    let current : Current
    let todayForecast : ForecastDay?
    
    var body: some View {
        VStack(spacing: 8){
            Text(location.name)
                .font(.system(size: 32,weight: .bold))
            
            AsyncImage(url: URL(string: "https:\(current.condition.icon)")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            .frame(width: 80, height: 80,alignment: .center)
            
            Text("\(Int(current.tempC))°")
                .font(.system(size: 64,weight: .thin))
            Text(current.condition.text)
                .font(.title3)
            
            if let today = todayForecast {
                Text("H:\(Int(today.day.maxtempC))° L:\(Int(today.day.mintempC))°")
                    .font(.headline)
            }
            
        }
    }
}
