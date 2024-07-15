//
//  WeatherManager.swift
//  WiTher
//
//  Created by mac.bernanda on 11/07/24.
//

import Foundation
import WeatherKit
import CoreLocation

@MainActor
class WeatherManager: ObservableObject {
    private let weatherService = WeatherService()
    private let sunRadiationManager = SunRadiationManager()
    @Published var weather: Weather?
    @Published var dailyForecast: [DayWeather] = []
    @Published var todayForecast: [WeatherTableData] = []
    @Published var tomorrowForecast: [WeatherTableData] = []
    @Published var dayAfterTomorrowForecast: [WeatherTableData] = []
    
    func getExtendedForecast(for location: CLLocation) async {
        do {
            let weather = try await weatherService.weather(for: location)
            let hourlyForecast = weather.hourlyForecast
            
            // Filter the forecast for tomorrow and the day after tomorrow
            let calendar = Calendar.current
            let tomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400))
            let dayAfterTomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400 * 2))
            
            //            let dataToday = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(.now))
            //
            //            let dataTomorrow = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(tomorrow))
            //
            //            let dataDayAfterTomorrow = sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(dayAfterTomorrow))
            //
            //
            
            self.todayForecast = hourlyForecast
                .filter { calendar.isDate($0.date, inSameDayAs: .now) }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghiData = SunRadiationManager.ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
                }
            
            print(todayForecast)
           
            
            self.tomorrowForecast = hourlyForecast
                .filter { calendar.isDate($0.date, inSameDayAs: tomorrow) }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghiData = SunRadiationManager.ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
                }
            
            self.dayAfterTomorrowForecast = hourlyForecast
                .filter { calendar.isDate($0.date, inSameDayAs: dayAfterTomorrow) }
                .enumerated()
                .map { index, forecast in
                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
                    let ghiData = SunRadiationManager.ghiData[index]
                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
                }
            
        } catch {
            print("Failed to fetch weather data: \(error)")
        }
    }
    
    func getWeather(latitude: Double, longitude: Double) {
        async {
            do {
                weather = try await Task.detached(priority: .userInitiated) {
                    return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
                }.value
                
                if let weather = weather {
                    dailyForecast = Array(weather.dailyForecast.forecast.prefix(3))
                }
            } catch {
                fatalError("\(error)")
            }
        }
    }

    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }

    var temp: String {
        guard let temp = weather?.currentWeather.temperature else {
            return "Connecting to Apple Weather Servers"
        }
        let convertedTemp = Int(temp.converted(to: .celsius).value)
        return "\(convertedTemp)"
    }

    var humidity: String {
        guard let humidity = weather?.currentWeather.humidity else {
            return "N/A"
        }
        let convertedHumidity = Int(humidity * 100)
        return "\(convertedHumidity)%"
    }

    func forecastForNextThreeDays() -> [(day: String, symbol: String, highTemp: String, lowTemp: String)] {
        return dailyForecast.map { dayWeather in
            let day = formatDateToDayOfWeek(dayWeather.date)
            let symbol = dayWeather.symbolName
            let highTemp = "\(Int(dayWeather.highTemperature.converted(to: .celsius).value))°C"
            let lowTemp = "\(Int(dayWeather.lowTemperature.converted(to: .celsius).value))°C"
            return (day, symbol, highTemp, lowTemp)
        }
    }
    
    private func formatDateToDayOfWeek(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
}

