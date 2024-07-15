//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Anthony on 12/07/24.
//

import Foundation
import WeatherKit

protocol WeatherServiceProtocol {
    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherModel
}
