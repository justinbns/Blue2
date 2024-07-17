//
//  PenmenCalculation.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//
import Foundation
import SwiftUI

func convertGhi(ghi: Double) -> Double{
    let newGhi = ghi == 0.0 ? 1.0 : ghi
    return newGhi * 0.0864 / 24
}

func convertTemperature(temperature: Measurement<UnitTemperature>) -> Double{
    return temperature.converted(to: .celsius).value
}

func convertWindSpeed(windSpeed: Measurement<UnitSpeed>) -> Double{
    return windSpeed.converted(to: .metersPerSecond).value
}

func calculateSaturationVaporPressure(temperature: Double) -> Double{
    let temp = (17.27*temperature)/(temperature+237.3)
    return 0.6108 * exp(temp)
}

func calculateActualVaporPressure(temperature: Double, humidity: Double) -> Double{
    let saturationVaporPressure = calculateSaturationVaporPressure(temperature: temperature)
    let actualVaporPressure = humidity * saturationVaporPressure
    return actualVaporPressure
}

func calculateSlopeOfVaporPressure(temperature: Double) -> Double{
    let saturationVaporPressure = calculateSaturationVaporPressure(temperature: temperature)
    let numerator = 4098 * saturationVaporPressure
    let denumerator = pow(temperature+237.3,2)
    let slopeOfVaporPressure = numerator / denumerator
    return slopeOfVaporPressure
}

func calculateRns(ghiCloudySky : Double,alpha : Double) -> Double{
    let rns = 0.408 * ((1 - alpha) * ghiCloudySky)
    return rns
}

func calculateRnl(ghiCloudySky : Double,ghiClearSky : Double,temperature : Double,humidity: Double) -> Double{
    let actualVaporPressure = calculateActualVaporPressure(temperature: temperature, humidity: humidity)
    let boltzman = 4.903e-9
    let rnl = boltzman * pow((temperature + 273.16), 4) * (0.34 - 0.14 * sqrt(actualVaporPressure)) * ((1.35 * ghiCloudySky/ghiClearSky) - 0.35)
    return rnl
}

func calculateNetRadiation(ghiCloudySky : Double,ghiClearSky : Double,temperature : Double,humidity: Double,alpha : Double) -> Double{
    let rns = calculateRns(ghiCloudySky: ghiCloudySky, alpha: 0.23)
    let rnl = calculateRnl(ghiCloudySky: ghiCloudySky, ghiClearSky: ghiCloudySky, temperature: temperature, humidity: humidity)
    let netRadiation = rns + rnl
    return netRadiation
}

func calculatePenmanMonteith(temperature: Double,windSpeed: Double,humidity: Double,ghiCloudySky : Double,ghiClearSky : Double) -> Double{
    let psychrometricConstant:Double = 0.067
    let slopeOfVaporPressure = calculateSlopeOfVaporPressure(temperature: temperature)
    let netRadiation = calculateNetRadiation(ghiCloudySky: ghiCloudySky, ghiClearSky: ghiClearSky, temperature: temperature, humidity: humidity, alpha: 0.23)
    let saturationVaporPressure = calculateSaturationVaporPressure(temperature: temperature)
    let actualVaporPressure = calculateActualVaporPressure(temperature: temperature, humidity: humidity)
    let diffVaporPressure = saturationVaporPressure - actualVaporPressure
    
    let numerator = 0.408 * slopeOfVaporPressure * netRadiation + psychrometricConstant * 37.5/(temperature+273) * windSpeed * diffVaporPressure
    
    let denumerator = slopeOfVaporPressure + psychrometricConstant * ( 1 + 0.34 * windSpeed)
    let dryingRate = numerator / denumerator
    return dryingRate //Convert To second
}

func calculateDryingTime(temperatureUnit: Measurement<UnitTemperature>,windSpeedUnit: Measurement<UnitSpeed>,humidity: Double,ghiCloudySky: Double,ghiClearSky:Double)->Double{
    let temperature = convertTemperature(temperature: temperatureUnit)
    let windSpeed = convertWindSpeed(windSpeed: windSpeedUnit)
    let convertedGhiClearSky = convertGhi(ghi: ghiClearSky)
    let convertedGhiCloudySky = convertGhi(ghi: ghiCloudySky)
    let IMC:Double = 75
    let FMC:Double = 10
    let weight:Double = 10
    let waterToBeRemoved: Double = weight * (IMC-FMC)/100
    let dryingRate = calculatePenmanMonteith(temperature: temperature, windSpeed: windSpeed, humidity: humidity, ghiCloudySky: convertedGhiCloudySky, ghiClearSky: convertedGhiClearSky)
    let dryingTime = waterToBeRemoved / dryingRate
    return dryingTime
}

func formatHoursToHoursAndMinutes(value : Double?) -> DryingTimeText {
    let dryingtime = value

    let totalMinutes = dryingtime! * 60
    let hoursPart = Int(totalMinutes) / 60
    let minutesPart = Int(totalMinutes) % 60
//    result.append("\(totalMinutes)")
    
    var color : Color
    if totalMinutes <= 180 {
        color = Color.green
    } else if totalMinutes > 180 && totalMinutes <= 300 {
        color = Color.yellow
    } else {
        color = Color.red
    }
    
    let result = DryingTimeText(color: color, hrs: hoursPart, min: minutesPart)
    return result
}
