//
//  ChooseDayViewModel.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import Foundation
import CoreLocation

class ChooseDayViewModel: ObservableObject {
    @Published var selected: ForecastDay = .today
    @Published var chosen: String = DateUtil.todayToString()
    @Published var forecast : [WeatherTableData] = []
    @Published var threeDayForecast: [WeatherTableDataSimple] = []
    @Published var isLoading : Bool = true
    
    private var weatherManager: WeatherManager = WeatherManager.shared
    
    @MainActor
    func getForecast(at location: CLLocation, on day: ForecastDay) async {
        LoggingService.log.debug("fetching forecast at \(location.description) on \(day) ")
        forecast = await weatherManager.getForecast(for: location, on: day)
    }

    @MainActor
    func getThreeDayForecast(for location : CLLocation) async {
        threeDayForecast = await weatherManager.getThreeDayWeather(for: location)
    }
}

