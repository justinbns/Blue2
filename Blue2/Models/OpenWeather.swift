//
//  OpenWeather.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//


struct SolarRadiationResponse: Codable {
    let lat: Double
    let lon: Double
    let date: String
    let interval: String
    let tz: String
    let sunrise: String
    let sunset: String
    let irradiance: Irradiance
}

struct Irradiance: Codable {
    let daily: [Daily]
    let intervals: [Interval]
}

struct Daily: Codable {
    let clearSky: Sky
    let cloudySky: Sky
    
    enum CodingKeys: String, CodingKey {
        case clearSky = "clear_sky"
        case cloudySky = "cloudy_sky"
    }
}

struct Interval: Codable {
    let start: String
    let end: String
    let clearSky: Sky
    let cloudySky: Sky
    
    enum CodingKeys: String, CodingKey {
        case start
        case end
        case clearSky = "clear_sky"
        case cloudySky = "cloudy_sky"
    }
}

struct Sky: Codable {
    let ghi: Double
    let dni: Double
    let dhi: Double
}

struct GHIData {
    let start: String
    let end: String
    let clearSkyGHI: Double
    let cloudySkyGHI: Double
}
