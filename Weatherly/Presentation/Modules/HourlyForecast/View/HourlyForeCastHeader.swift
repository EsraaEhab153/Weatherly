//
//  HourlyForeCastHeader.swift
//  Weatherly
//
//  Created by Esraa Ehab on 22/06/2026.
//

import SwiftUI

struct HourlyForeCastHeader: View {
    let hours: [Hour]
    let timeOfDay: TimeOfDay
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(hours, id: \.time) { hour in
                    HStack {
                        Text(hour.time.toHourlyTime())
                            .font(.title3)
                            .foregroundColor(timeOfDay.textColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        AsyncImage(url: URL(string: "https:\(hour.condition.icon)")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        
                        
                        Text("\(Int(hour.tempC))°")
                            .font(.title2)
                            .foregroundColor(timeOfDay.textColor)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.6), lineWidth: 1.5)
                    )
                }
            }
            .padding()
        }
    }
}
