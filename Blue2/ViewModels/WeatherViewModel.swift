//
//  LocationViewModel.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject, LocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var cityName: String = "Unknown Location"
    @Published var latitude: Double = -6.302620705878877
    @Published var longitude: Double = 106.65203626737502
    
    @Published var todayForecast: [WeatherTableData] = []
    @Published var tomorrowForecast: [WeatherTableData] = []
    @Published var dayAfterTomorrowForecast: [WeatherTableData] = []
    
    private var locationManager: LocationManager
    private var weatherManager: WeatherManager
    
    init(locationManager: LocationManager = LocationManager(), weatherManager: WeatherManager = WeatherManager()) {
        self.locationManager = locationManager
        self.weatherManager = weatherManager
        
        self.locationManager.delegate = self
        self.updateAuthorizationStatus()
    }
    
    func didUpdateLocation(latitude: Double, longitude: Double, cityName: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
    }
    
    func didFailWithError(error: Error) {
        LoggingService.log.error(error)
    }
    
    @MainActor
    func getTodayForecast() async {
        todayForecast = await weatherManager.getTodayForecast(for: CLLocation(latitude: latitude, longitude: longitude))
    }
    
    @MainActor
    func getTomorrowForecast() async {
        tomorrowForecast = await weatherManager.getTomorrowForecast(for: CLLocation(latitude: latitude, longitude: longitude))
    }
    
    @MainActor
    func getDayAfterTomorrowForecast() async {
        dayAfterTomorrowForecast = await weatherManager.getTheDayAfterTomorrowForecast(for: CLLocation(latitude: latitude, longitude: longitude))
    }
    
    private func updateAuthorizationStatus() {
        authorizationStatus = locationManager.authorizationStatus
    }
}

