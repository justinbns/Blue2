////
////  WeatherManager.swift
////  WiTher
////
////  Created by mac.bernanda on 11/07/24.
////
//
//import Foundation
//import WeatherKit
//import CoreLocation
//
//@MainActor
//class WeatherManager: ObservableObject {
//    private let weatherService = WeatherService()
//    private let sunRadiationManager = SunRadiationManager()
//    @Published var todayForecast: [WeatherTableData] = []
//    @Published var tomorrowForecast: [WeatherTableData] = []
//    @Published var dayAfterTomorrowForecast: [WeatherTableData] = []
//    
//    func getExtendedForecast(for location: CLLocation) async {
//        do {
//            let weather = try await weatherService.weather(for: location)
//            let hourlyForecast = weather.hourlyForecast
//            
//            // Filter the forecast for tomorrow and the day after tomorrow
//            let calendar = Calendar.current
//            let tomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400))
//            let dayAfterTomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400 * 2))
//            
//            //            let dataToday = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(.now))
//            //
//            //            let dataTomorrow = await sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(tomorrow))
//            //
//            //            let dataDayAfterTomorrow = sunRadiationManager.fetchSolarRadiationData(lat: location.coordinate.latitude, lon: location.coordinate.longitude, date: formatDateToString(dayAfterTomorrow))
//            //
//            //
//            
//            self.todayForecast = hourlyForecast
//                .filter { calendar.isDate($0.date, inSameDayAs: .now) }
//                .enumerated()
//                .map { index, forecast in
//                    // Fetch corresponding GHI data based on index (assuming index corresponds to hour)
//                    let ghiData = SunRadiationManager.ghiData[index]
//                    return WeatherTableData(forecast: forecast, ghiData.clearSkyGHI)
//                }
//            
//            print(todayForecast)
//           
//            
//            //            self.tomorrowForecast = hourlyForecast
//            //                .filter { calendar.isDate($0.date, inSameDayAs: tomorrow) }
//            //                .map { WeatherData(forecast: $0) }
//            //
//            //            self.dayAfterTomorrowForecast = hourlyForecast
//            //                .filter { calendar.isDate($0.date, inSameDayAs: dayAfterTomorrow) }
//            //                .map { WeatherData(forecast: $0) }
//            
//        } catch {
//            print("Failed to fetch weather data: \(error)")
//        }
//    }
//}
//
