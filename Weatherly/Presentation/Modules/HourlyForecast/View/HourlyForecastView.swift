//
//  HourlyForecast.swift
//  Weatherly
//
//  Created by Esraa Ehab on 19/06/2026.
//

import SwiftUI

struct HourlyForecastView: View {
    let hours: [Hour]
    let dateString: String
    
    var currentTimeOfDay : TimeOfDay {
        Date().timeOfDay
    }
    
    var body: some View {
        ZStack {
            
            
            Image(currentTimeOfDay.backgroundImageName)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text(dateString.toFormattedDate())
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(currentTimeOfDay.textColor)
                                    .padding(.top, 10)
                
                HourlyForeCastHeader(hours: hours)
            }
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    let dummyCondition = Condition(
        text: "Partly cloudy",
        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png", 
        code: 1003
    )
    
    let dummyHours = [
        Hour(time: "2026-06-22 15:00", tempC: 15.0, condition: dummyCondition),
        Hour(time: "2026-06-22 16:00", tempC: 14.0, condition: dummyCondition),
        Hour(time: "2026-06-22 17:00", tempC: 13.0, condition: dummyCondition),
        Hour(time: "2026-06-22 18:00", tempC: 12.0, condition: dummyCondition)
    ]
    
    return HourlyForecastView(hours: dummyHours, dateString: "2026-06-22")
}
