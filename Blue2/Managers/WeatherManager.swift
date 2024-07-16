//
//  WeatherManager.swift
//  WiTher
//
//  Created by mac.bernanda on 11/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager: WeatherManagerProtocol {
    private let weatherService = WeatherService()
    private let openWeatherService = OpenWeatherService()
    static var shared = WeatherManager()
    
    func getTodayForecast(for location: CLLocation) async -> [WeatherTableData] {
        do {
            let weather = try await weatherService.weather(for: location)
            let ghiData = await openWeatherService.fetchSolarRadiationData(for: location, at: .now)
            let hourlyForecast = weather.hourlyForecast
            
            let forecast = hourlyForecast
                .filter { forecast in
                    let calendar = Calendar.current
                    let date = forecast.date
                    let hour = calendar.component(.hour, from: date)
                    return calendar.isDate(date, inSameDayAs: .now) && hour >= 6 && hour <= 17
                }
                .enumerated()
                .map { index, forecast in
                    let ghi = ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiClear: ghi.clearSkyGHI, ghiCloudy: ghi.cloudySkyGHI)
                }
            
            return forecast
            
        } catch {
            LoggingService.log.error("Failed to fetch weather data: \(error)")
        }
        
        return []
    }
    
    func getTomorrowForecast(for location: CLLocation) async -> [WeatherTableData] {
        do {
            let weather = try await weatherService.weather(for: location)
            let hourlyForecast = weather.hourlyForecast
            let tomorrow = DateUtil.getTomorrow()
            let ghiData = await openWeatherService.fetchSolarRadiationData(for: location, at: tomorrow)
            
            
            let forecast = hourlyForecast
                .filter { forecast in
                    let calendar = Calendar.current
                    let date = forecast.date
                    let hour = calendar.component(.hour, from: date)
                    return calendar.isDate(date, inSameDayAs: tomorrow) && hour >= 6 && hour <= 17
                }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghi = ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiClear: ghi.clearSkyGHI, ghiCloudy: ghi.cloudySkyGHI)
                }
            
            return forecast
            
        } catch {
            LoggingService.log.error("Failed to fetch weather data: \(error)")
        }
        
        return []
    }
    
    func getTheDayAfterTomorrowForecast(for location: CLLocation) async -> [WeatherTableData] {
        do {
            let weather = try await weatherService.weather(for: location)
            let hourlyForecast = weather.hourlyForecast
            let theDayAfterTomorrow = DateUtil.getTheDayAfterTomorrow()
            let ghiData = await openWeatherService.fetchSolarRadiationData(for: location, at: theDayAfterTomorrow)
            
            let forecast = hourlyForecast
                .filter { forecast in
                    let calendar = Calendar.current
                    let date = forecast.date
                    let hour = calendar.component(.hour, from: date)
                    return calendar.isDate(date, inSameDayAs: theDayAfterTomorrow) && hour >= 6 && hour <= 17
                }
                .enumerated()
                .map { index, forecast in
                    let ghi = ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiClear: ghi.clearSkyGHI, ghiCloudy: ghi.cloudySkyGHI)
                }
            
            return forecast
            
        } catch {
            LoggingService.log.error("Failed to fetch weather data: \(error)")
        }
        
        return []
    }
    
    func getThreeDayWeather(for location: CLLocation) async -> [WeatherTableDataSimple] {
        do {
            let weather = try await weatherService.weather(for: location)
            let threeDayForecast = Array(weather.dailyForecast.forecast.prefix(3))
            
            return threeDayForecast.map { dayWeather in
                let day = DateUtil.formatDateToDayOfWeek(dayWeather.date)
                let symbol = dayWeather.symbolName
                let highTemp = "\(Int(dayWeather.highTemperature.converted(to: .celsius).value))°C"
                let lowTemp = "\(Int(dayWeather.lowTemperature.converted(to: .celsius).value))°C"
                return WeatherTableDataSimple(day: day, symbol: symbol, highTemp: highTemp, lowTemp: lowTemp)
            }
            
        } catch {
            fatalError("\(error)")
        }
    }
    
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherModel {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let weather = try await weatherService.weather(for: location)
        let currentWeather = weather.currentWeather
        let symbolName = currentWeather.symbolName
        let temperature = currentWeather.temperature.converted(to: .celsius).value
        let humidity = currentWeather.humidity
        
        return WeatherModel(temperature: temperature, humidity: humidity, symbolName: symbolName)
    }
    
    
    func getBestDryingTime(at span: [WeatherTableData]) async -> OptimalDrying? {
        // Filter out entries without a dryingTimeValue
        let validEntries = span.filter { $0.dryingTimeValue != nil }
        
        // Find the entry with the minimum dryingTimeValue
        guard let bestEntry = validEntries.min(by: { $0.dryingTimeValue! < $1.dryingTimeValue! }) else {
            LoggingService.log.info("kosong")
            return nil
        }
        
        // Convert dryingTimeValue to minutes
        let dryingTimeInMinutes = Int(bestEntry.dryingTimeValue! * 60)
        
        LoggingService.log.info("best \(bestEntry.date)")
        // Return the optimal drying time
        return OptimalDrying(date: bestEntry.date, dryingTimeInMinutes: dryingTimeInMinutes)
    }
    
}
