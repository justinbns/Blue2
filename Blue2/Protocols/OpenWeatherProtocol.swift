//
//  OpenWeatherProtocol.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import CoreLocation

protocol OpenWeatherProtocol {
    func fetchSolarRadiationData(for location: CLLocation, at date: Date) async -> [GHIData]
//    func fetchSolarRadiation(for location: CLLocation, at date: Date, completion: @escaping (Result<[GHIData], Error>) -> Void)
}

