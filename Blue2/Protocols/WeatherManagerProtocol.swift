//
//  WeatherManagerDelegate.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import CoreLocation

protocol WeatherManagerProtocol {
    func getForecast(for location: CLLocation, on day: ForecastDay) async -> [WeatherTableData]
    func getThreeDayWeather(for location: CLLocation) async -> [WeatherTableDataSimple]
    func getBestDryingTime(at span: [WeatherTableData]) async -> OptimalDrying?
}
