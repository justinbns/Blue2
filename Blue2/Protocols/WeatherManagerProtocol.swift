//
//  WeatherManagerDelegate.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import CoreLocation

protocol WeatherManagerProtocol {
    func getTodayForecast(for location: CLLocation) async -> [WeatherTableData]
    func getTomorrowForecast(for location: CLLocation) async -> [WeatherTableData]
    func getTheDayAfterTomorrowForecast(for location: CLLocation) async -> [WeatherTableData]
}
