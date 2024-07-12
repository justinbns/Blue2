//
//  Weather.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//

import Foundation
import WeatherKit

struct WeatherTableData {
    let date: Date
    let temperature: Measurement<UnitTemperature>
    let windSpeed: Measurement<UnitSpeed>
    let humidity: Double
    let ghi : Double
    let dryingTime : Double?
    
    init(forecast: HourWeather, _ ghi : Double) {
        self.date = forecast.date
        self.temperature = forecast.temperature
        self.windSpeed = forecast.wind.speed
        self.humidity = forecast.humidity
        self.ghi = ghi
        self.dryingTime = calculatePenman (
            temperature: temperature,
            windSpeed: windSpeed,
            humidity: humidity,
            ghi: ghi,
            clothesType: "shirt")
    }
}
