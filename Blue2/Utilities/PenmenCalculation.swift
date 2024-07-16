//
//  PenmenCalculation.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//
import Foundation
import SwiftUI

import Foundation

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
    return humidity * calculateSaturationVaporPressure(temperature: temperature)
}

func calculateSlopeOfVaporPressure(temperature: Double) -> Double{
    let temp = 4098 * calculateSaturationVaporPressure(temperature: temperature)
    return temp/pow(temperature+237.3,2)
}

func calculateRns(ghiCloudySky : Double,alpha : Double) -> Double{
    return 0.408 * ((1 - alpha) * ghiCloudySky)
}

func calculateRnl(ghiCloudySky : Double,ghiClearSky : Double,temperature : Double,humidity: Double) -> Double{
    let boltzman = 4.903e-9
    let temp = pow((temperature + 273.16), 4)
    let temp2 = 0.34 - 0.14 * sqrt(calculateActualVaporPressure(temperature: temperature, humidity: humidity))
    let temp3 = (1.35 * ghiCloudySky/ghiClearSky) - 0.35
    return boltzman * temp * temp2 * temp3
}

func calculateNetRadiation(ghiCloudySky : Double,ghiClearSky : Double,temperature : Double,humidity: Double,alpha : Double) -> Double{
    return calculateRns(ghiCloudySky: ghiCloudySky, alpha: 0.23) + calculateRnl(ghiCloudySky: ghiCloudySky, ghiClearSky: ghiCloudySky, temperature: temperature, humidity: humidity)
}

func calculateAerodynamicResistance(windSpeed: Double) -> Double{
    return 208/windSpeed
}

func calculatePenmanMonteith(temperature: Double,windSpeed: Double,humidity: Double,ghiCloudySky : Double,ghiClearSky : Double) -> Double{
    let psychrometricConstant:Double = 0.067
    
    let temp1 = 0.408 * calculateSlopeOfVaporPressure(temperature: temperature) * calculateNetRadiation(ghiCloudySky: ghiCloudySky, ghiClearSky: ghiClearSky, temperature: temperature, humidity: humidity, alpha: 0.23)
    
    let temp2 = psychrometricConstant * 37.5/(temperature+273) * windSpeed * (calculateSaturationVaporPressure(temperature: temperature) - calculateActualVaporPressure(temperature: temperature, humidity: humidity))
    
    let numerator =  temp1 + temp2
    
    let denumerator = calculateSlopeOfVaporPressure(temperature: temperature) + psychrometricConstant * ( 1 + 0.34 * windSpeed)
    let E = numerator / denumerator
    return E //Convert To second
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
    let E: Double = calculatePenmanMonteith(temperature: temperature, windSpeed: windSpeed, humidity: humidity, ghiCloudySky: convertedGhiCloudySky, ghiClearSky: convertedGhiClearSky)
    return waterToBeRemoved / E
}

func formatHoursToHoursAndMinutes(value : Double?) -> [String] {
    var result: [String] = []
    let dryingtime = value

    let totalMinutes = dryingtime! * 60
    let hoursPart = Int(totalMinutes) / 60
    let minutesPart = Int(totalMinutes) % 60
    result.append("\(totalMinutes)")
    
    if totalMinutes <= 180 {
        result.append("Color.green")
    } else if totalMinutes > 180 && totalMinutes <= 300 {
        result.append("Color.yellow")
    } else {
        result.append("Color.red")
    }
    
    result.append("\(hoursPart) hrs \(minutesPart) mins")
    return result
}

func stringToColor(colorString: String) -> Color? {
    let colorMaping: [String: Color] = [
        "Color.green": .green,
        "Color.yellow": .yellow,
        "Color.red": .red
    ]
    
    return colorMaping[colorString]
}
