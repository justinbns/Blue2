//
//  PenmenCalculation.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//
import Foundation

func calculatePenman(temperature: Measurement<UnitTemperature>,
                     windSpeed: Measurement<UnitSpeed>,
                     humidity: Double,
                     ghi: Double,
                     clothesType: String) -> Double? {
    
    // Constants
    let b: Double = 0.5
    let c: Double = 0.34
    
    // Convert temperature to Celsius
    let tempCelsius = temperature.converted(to: .celsius).value
    
    // Calculate saturation vapor pressure (es) in kPa
    let es = 0.6108 * exp((17.27 * tempCelsius) / (tempCelsius + 237.3))
    
    // Calculate actual vapor pressure (ea) in kPa
    let ea = humidity * es
    
    // Calculate slope of the saturation vapor pressure curve (Delta) in kPa/°C
    let delta = (4098 * es) / pow((tempCelsius + 237.3), 2)
    
    // Convert wind speed to m/s
    let windSpeedMS = windSpeed.converted(to: .metersPerSecond).value
    
    // Calculate drying rate using Penman equation
    let dryingRate = (ghi + b * windSpeedMS * (es - ea)) / (delta + 0.665 * (1 + c * windSpeedMS))
    
    // Adjust drying rate based on clothes type
    var factor: Double
    switch clothesType {
    case "shirt":
        factor = 1.2 // Adjusted drying rate factor for shirts
    case "towel":
        factor = 0.8 // Adjusted drying rate factor for towels
    default:
        return nil // Invalid clothes type
    }
    
    let adjustedDryingRate = dryingRate * factor
    
    // Calculate drying time (in hours)
    let dryingTime = 1 / adjustedDryingRate
    
    return dryingTime
}
