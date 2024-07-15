//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Anthony on 12/07/24.
//

import Foundation
import WeatherKit

class WeatherService: WeatherServiceProtocol {
    private let weatherKitService = WeatherKit.WeatherService.shared
    
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherModel {
        let weather = try await weatherKitService.weather(for: .init(latitude: latitude, longitude: longitude))
        return WeatherModel(weather: weather)
    }
}
