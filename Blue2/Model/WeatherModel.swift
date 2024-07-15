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

extension WeatherModel {
    static func mockSunny() -> WeatherModel {
        return WeatherModel(temperature: 25.0, humidity: 0.5, symbolName: "sun.max")
    }

    static func mockSunCloud() -> WeatherModel {
        return WeatherModel(temperature: 22.0, humidity: 0.6, symbolName: "cloud.sun")
    }

    static func mockCloudy() -> WeatherModel {
        return WeatherModel(temperature: 20.0, humidity: 0.7, symbolName: "cloud")
    }

    static func mockRainy() -> WeatherModel {
        return WeatherModel(temperature: 18.0, humidity: 0.8, symbolName: "cloud.rain")
    }

    static func mockStorm() -> WeatherModel {
        return WeatherModel(temperature: 16.0, humidity: 0.9, symbolName: "cloud.bolt.rain")
    }
}


