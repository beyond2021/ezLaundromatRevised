//
//  LocationManager.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/28/24.
//

import Foundation
import CoreLocation

class YourLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var pickUpLocationEnabled: Bool = false
    var locationManager: CLLocationManager?
    let targetRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 40.82094, longitude: -73.99136), radius: 1000, identifier: "EZRegionIdentifier")
    // Define your target region here (San Francisco coordinates used as an example)
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        if targetRegion.contains(userLocation.coordinate) {
            pickUpLocationEnabled = true
            print("Feature enabled within target region")
        } else {
            pickUpLocationEnabled = false
            print("Feature disabled outside target region")
        }
    }
}

//Latitude: 40.82094, Longitude: -73.99136, Quality: P1AAA
