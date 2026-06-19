//
//  StateCard.swift
//  Weatherly
//
//  Created by Esraa Ehab on 19/06/2026.
//

import SwiftUI

struct StateCard: View {
    let title : String
    let value : String
    let customImageName: String
    
    var body: some View {
        VStack{
            Image(customImageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
            Text(title)
                .font(.caption)
                .opacity(0.8)
            Text(value)
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(15)
    }
}
