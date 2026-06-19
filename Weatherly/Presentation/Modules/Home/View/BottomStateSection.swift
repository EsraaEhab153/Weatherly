//
//  BottomStateSection.swift
//  Weatherly
//
//  Created by Esraa Ehab on 19/06/2026.
//

import SwiftUI

struct BottomStateSection: View {
    
    let current : Current
    
    var body: some View {
        VStack{
            HStack{
                StateCard(title: "VISIBILITY", value: "\(Int(current.visKm)) km", customImageName: "humidity")
                StateCard(title: "HUMIDITY", value: "\(current.humidity)%", customImageName: "visible")
            }
            HStack(spacing: 20) {
                StateCard(title: "FEELS LIKE", value: "\(Int(current.feelslikeC))°", customImageName: "weather")
                StateCard(title: "PRESSURE", value: "\(Int(current.pressureMb))", customImageName: "barometer")
            }
        }
    }
}
