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
    let dryingTime : [String]
    let symbolname : String
    
    init(forecast: HourWeather, _ ghi : Double) {
        self.date = forecast.date
        self.temperature = forecast.temperature
        self.windSpeed = forecast.wind.speed
        self.humidity = forecast.humidity
        self.ghi = ghi
        self.dryingTime = formatHoursToHoursAndMinutes(
                    temperature: temperature,
                    windSpeed: windSpeed,
                    humidity: humidity,
                    ghi: ghi,
                    clothesType: "shirt") // 0-3 ijo, 3-6 kuning, 6++ merah
                self.symbolname = forecast.symbolName
    }
}

struct WeatherTableDataSimple {
    let day: String
    let symbol: String
    let highTemp: String
    let lowTemp: String
}