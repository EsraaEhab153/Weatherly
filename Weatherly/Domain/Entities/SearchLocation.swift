//
//  SearchLocation.swift
//  Weatherly
//
//  Created by Esraa Ehab on 23/06/2026.
//

import Foundation
struct SearchLocation : Codable , Identifiable{
    let id : Int
    let name : String
    let region : String
    let country : String
    let lat : Double
    let lon : Double
}
