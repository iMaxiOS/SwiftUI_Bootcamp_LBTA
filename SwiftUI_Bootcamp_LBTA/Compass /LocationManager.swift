//
//  LocationManager.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 27.05.2024.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var degrees: Double = 0
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingHeading()
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        degrees = newHeading.trueHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {} 
    
}

func compassDirection(_ degress: Double) -> String {
    let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW",]
    let index = Int((degress + 22.5) / 45.0) & 7
    return directions[index]
}
