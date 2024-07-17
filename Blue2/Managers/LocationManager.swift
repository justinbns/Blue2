//
//  LocationManager.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    var authorizationStatus: CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .restricted, .denied, .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.didFailWithError(error: error)
            } else if let placemark = placemarks?.first, let city = placemark.locality {
                self.delegate?.didUpdateLocation (
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude,
                    cityName: city
                )
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error: error)
    }
}
