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

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: WeatherModel?
    var weatherManager: WeatherManager = WeatherManager.shared
    
    @MainActor
    func fetchWeather(at location: CLLocation) async {
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        do {
            self.currentWeather = try await weatherManager.getWeather(latitude: lat, longitude: long)
        } catch {
            LoggingService.log.error("Failed to fetch weather: \(error)")
        }
    }
    
    var temperature: String {
        guard let temp = self.currentWeather?.temperature else {
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

