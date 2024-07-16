//
//  SunRadiationManager.swift
//  Blue2
//
//  Created by mac.bernanda on 11/07/24.
//

import Foundation
import Combine
import Alamofire
import CoreLocation

class OpenWeatherService: OpenWeatherProtocol {
    private let apiKey = EnvManager.shared.API_KEY
    
    static var dummyGhiData: [GHIData] = [
        GHIData(start: "WK:WK", end: "01:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "01:00", end: "02:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "02:00", end: "03:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "03:00", end: "04:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "04:00", end: "05:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "05:00", end: "06:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "06:00", end: "07:00", clearSkyGHI: 54.08, cloudySkyGHI: 22.93),
        GHIData(start: "07:00", end: "08:00", clearSkyGHI: 262.51, cloudySkyGHI: 106.57),
        GHIData(start: "08:00", end: "09:00", clearSkyGHI: 486.69, cloudySkyGHI: 271.31),
        GHIData(start: "09:00", end: "10:00", clearSkyGHI: 680.02, cloudySkyGHI: 443.28),
        GHIData(start: "10:00", end: "11:00", clearSkyGHI: 820.11, cloudySkyGHI: 504.69),
        GHIData(start: "11:00", end: "12:00", clearSkyGHI: 893.0, cloudySkyGHI: 570.07),
        GHIData(start: "12:00", end: "13:00", clearSkyGHI: 891.8, cloudySkyGHI: 671.75),
        GHIData(start: "13:00", end: "14:00", clearSkyGHI: 4816.63, cloudySkyGHI: 4966.21),
        GHIData(start: "14:00", end: "15:00", clearSkyGHI: 674.57, cloudySkyGHI: 298.5),
        GHIData(start: "15:00", end: "16:00", clearSkyGHI: 479.78, cloudySkyGHI: 218.66),
        GHIData(start: "16:00", end: "17:00", clearSkyGHI: 254.97, cloudySkyGHI: 113.0),
        GHIData(start: "17:00", end: "18:00", clearSkyGHI: 49.4, cloudySkyGHI: 20.45),
        GHIData(start: "18:00", end: "19:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "19:00", end: "20:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "20:00", end: "21:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "21:00", end: "22:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "22:00", end: "23:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
        GHIData(start: "23:00", end: "00:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0)
    ]
    
    func fetchSolarRadiationData(for location: CLLocation, at date: Date) async -> [GHIData] {
        if apiKey == "" {
            LoggingService.log.info("API-KEY is not presented, returning dummy data")
            return OpenWeatherService.dummyGhiData
        }
        
        let tz = "+07:00"
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let interval = "1h"
        let date = DateUtil.formatDateToString(date)
        
        let urlString = "https://api.openweathermap.org/energy/1.0/solar/interval_data?lat=\(lat)&lon=\(lon)&date=\(date)&tz=\(tz)&interval=\(interval)&appid=\(apiKey)"
        //        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return [] }
        
        return await withCheckedContinuation { continuation in
            AF.request(url, interceptor: .retryPolicy).validate().responseDecodable(of: SolarRadiationResponse.self) { res in
                switch res.result {
                case let .success(data):
                    let ghiDataArray = data.irradiance.intervals.map { interval in
                        GHIData(
                            start: interval.start,
                            end: interval.end,
                            clearSkyGHI: interval.clearSky.ghi,
                            cloudySkyGHI: interval.cloudySky.ghi
                        )
                    }
                    continuation.resume(returning: ghiDataArray)
                case let .failure(error):
                    LoggingService.log.error(error)
                    LoggingService.log.info("error fetching data, returning dummy data")
                    continuation.resume(returning: OpenWeatherService.dummyGhiData)
                }
            }
        }
    }
}



