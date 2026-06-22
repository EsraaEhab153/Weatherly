//
//  LocationManager.swift
//  Weatherly
//
//  Created by Esraa Ehab on 22/06/2026.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, ObservableObject ,CLLocationManagerDelegate{
    private let manager = CLLocationManager()
    
   @Published var location : CLLocation?
   @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requsetLocation(){
        isLoading = true
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error getting location : \(error.localizedDescription)")
        isLoading = false
    }
}
