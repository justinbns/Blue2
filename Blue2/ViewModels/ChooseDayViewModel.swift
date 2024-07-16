//
//  ChooseDayViewModel.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import Foundation
import CoreLocation

class ChooseDayViewModel: ObservableObject {
    let location : CLLocation
    
    @Published var selected: String = "first"
    @Published var chosen: String = DateUtil.todayToString()
    @Published var threeDayForecast: [WeatherTableDataSimple] = []
    @Published var todayForecast: [WeatherTableData] = []
    @Published var tomorrowForecast: [WeatherTableData] = []
    @Published var dayAfterTomorrowForecast: [WeatherTableData] = []
    
    private var weatherManager: WeatherManager = WeatherManager.shared
    
    init(location: CLLocation) {
        self.location = location
    }
    
    @MainActor
    func getTodayForecast() async {
        todayForecast = await weatherManager.getTodayForecast(for: location)
    }
    
    @MainActor
    func getTomorrowForecast() async {
        tomorrowForecast = await weatherManager.getTomorrowForecast(for: location)
    }
    
    @MainActor
    func getDayAfterTomorrowForecast() async {
        dayAfterTomorrowForecast = await weatherManager.getTheDayAfterTomorrowForecast(for: location)
    }
    
    @MainActor
    func getThreeDayForecast() async {
        threeDayForecast = await weatherManager.getThreeDayWeather(for: location)
    }
}

