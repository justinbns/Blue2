//
//  LocationViewModel.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import Foundation
import Combine
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject, LocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var cityName: String = "Unknown Location"
    @Published var location: CLLocation = CLLocation(latitude: -6.302620705878877, longitude: 106.65203626737502)
    @Published var currentWeather: WeatherModel?
    
    private var locationManager: LocationManager
    var weatherManager: WeatherManager = WeatherManager.shared
    
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
        LoggingService.log.error(error)
    }
    
    private func updateAuthorizationStatus() {
        authorizationStatus = locationManager.authorizationStatus
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async {
           do {
               self.currentWeather = try await weatherManager.getWeather(latitude: latitude, longitude: longitude)
           } catch {
               LoggingService.log.error("Failed to fetch weather: \(error)")
           }
       }
    
    var temperature: String {
            guard let temp = currentWeather?.temperature else {
                return "-"
            }
            return "\(Int(temp))°"
        }
        
        var humidity: String {
            guard let humidity = currentWeather?.humidity else {
                return "N/A"
            }
            return "\(Int(humidity * 100))%"
        }
        
        var symbol: String {
            currentWeather?.symbolName ?? "xmark"
        }
       
    var weatherCondition: WeatherCondition {
        currentWeather?.weatherCondition ?? .sunny
    }
}

