//
//  LocationViewModel.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import Foundation
import Combine
import CoreLocation

class LocationViewModel: ObservableObject, LocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var cityName: String = "-"
    @Published var temperature: String = "-"
    @Published var location: CLLocation = CLLocation(latitude: -6.302620705878877, longitude: 106.65203626737502)
    
    private var locationManager: LocationManager
    
    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
        self.updateAuthorizationStatus()
    }
    
    func didUpdateLocation(latitude: Double, longitude: Double, cityName: String) {
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.cityName = cityName
    }
    
    func didFailWithError(error: Error) {
        print("Error fetching location: \(error)")
    }
    
    private func updateAuthorizationStatus() {
        authorizationStatus = locationManager.authorizationStatus
    }
}

