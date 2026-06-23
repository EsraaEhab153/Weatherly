//
//  SavedLocations.swift
//  Weatherly
//
//  Created by Esraa Ehab on 23/06/2026.
//

import Foundation
import SwiftData

@Model
class SavedLocations{
    @Attribute(.unique) var name : String
    var country : String
    var lat : Double
    var lon : Double
    
    init(name: String, country: String, lat: Double, lon: Double) {
        self.name = name
        self.country = country
        self.lat = lat
        self.lon = lon
    }
}
