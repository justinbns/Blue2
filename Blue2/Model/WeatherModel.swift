//
//  WeatherModel.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import Foundation
import WeatherKit

struct WeatherModel {
    let temperature: Double
    let humidity: Double
    let symbolName: String
    
    init(weather: Weather) {
        self.temperature = weather.currentWeather.temperature.converted(to: .celsius).value
        self.humidity = weather.currentWeather.humidity
        self.symbolName = weather.currentWeather.symbolName
    }
    
    init(temperature: Double, humidity: Double, symbolName: String) {
        self.temperature = temperature
        self.humidity = humidity
        self.symbolName = symbolName
    }
}

