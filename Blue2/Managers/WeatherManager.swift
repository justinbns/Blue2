//
//  WeatherManager.swift
//  WiTher
//
//  Created by mac.bernanda on 11/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager: ObservableObject, WeatherManagerProtocol {
    private let weatherService = WeatherService()
    private let ghiService = SunRadiationManager()

    func getTodayForecast(for location: CLLocation) async -> [WeatherTableData] {
        do {
            let weather = try await weatherService.weather(for: location)
            let hourlyForecast = weather.hourlyForecast
            
            let forecast = hourlyForecast
                .filter { Calendar.current.isDate($0.date, inSameDayAs: .now) }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghiData = SunRadiationManager.ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
                }

            return forecast
//            let dataToday = await ghiService.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(.now))
//
            
            // Filter the forecast for tomorrow and the day after tomorrow
//            let calendar = Calendar.current
//            let tomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400))
//            let dayAfterTomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400 * 2))
            
            //            let dataToday = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(.now))
            //
            //            let dataTomorrow = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(tomorrow))
            //
            //            let dataDayAfterTomorrow = sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(dayAfterTomorrow))
            //
            
           
            //            self.tomorrowForecast = hourlyForecast
            //                .filter { calendar.isDate($0.date, inSameDayAs: tomorrow) }
            //                .map { WeatherData(forecast: $0) }
            //
            //            self.dayAfterTomorrowForecast = hourlyForecast
            //                .filter { calendar.isDate($0.date, inSameDayAs: dayAfterTomorrow) }
            //                .map { WeatherData(forecast: $0) }
            
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
            
            let forecast = hourlyForecast
                .filter { Calendar.current.isDate($0.date, inSameDayAs: tomorrow) }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghiData = SunRadiationManager.ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
                }

            return forecast
            
            //            let dataTomorrow = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(tomorrow))
            //
         
            
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
            
            let forecast = hourlyForecast
                .filter { Calendar.current.isDate($0.date, inSameDayAs: theDayAfterTomorrow) }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghiData = SunRadiationManager.ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
                }

            return forecast
    
            //            let dataDayAfterTomorrow = sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(dayAfterTomorrow))
            //
        
        } catch {
            LoggingService.log.error("Failed to fetch weather data: \(error)")
        }
        
        return []
    }
    
    
}

