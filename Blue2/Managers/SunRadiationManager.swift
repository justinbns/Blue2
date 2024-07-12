//
//  SunRadiationManager.swift
//  Blue2
//
//  Created by mac.bernanda on 11/07/24.
//

import Foundation
import Combine

struct SunRadiationResponse: Codable {
    let lat: Double
    let lon: Double
    let date: String
    let interval: String
    let tz: String
    let sunrise: String
    let sunset: String
    let irradiance: IrradianceData
}

struct IrradianceData: Codable {
    let daily: [DailyIrradiance]
    let intervals: [IntervalIrradiance]
}

struct DailyIrradiance: Codable {
    let clearSky: SkyIrradiance
    let cloudySky: SkyIrradiance
    
    enum CodingKeys: String, CodingKey {
        case clearSky = "clear_sky"
        case cloudySky = "cloudy_sky"
    }
}

struct IntervalIrradiance: Codable {
    let start: String
    let end: String
    let clearSky: SkyIrradiance
    let cloudySky: SkyIrradiance
    
    enum CodingKeys: String, CodingKey {
        case start
        case end
        case clearSky = "clear_sky"
        case cloudySky = "cloudy_sky"
    }
}

struct SkyIrradiance: Codable {
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

class SunRadiationManager: ObservableObject {
    private var cancellable: AnyCancellable?
    
    static var ghiData: [GHIData] = [
            GHIData(start: "00:00", end: "01:00", clearSkyGHI: 0.0, cloudySkyGHI: 0.0),
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
            GHIData(start: "13:00", end: "14:00", clearSkyGHI: 816.63, cloudySkyGHI: 566.21),
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
    
//    func fetchSolarRadiationData(lat: Double, lon: Double, date: String) async {
//            let tz = "+07:00"
//            let apiKey = EnvManager.shared.API_KEY
////            let urlString = "https://api.openweathermap.org/energy/1.0/solar/data?lat=\(lat)&lon=\(lon)&date=\(date)&tz=\(tz)&appid=\(apiKey)"
//            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat={\(lat)}&lon={\(lon)}&appid={\(apiKey)}"
//            guard let url = URL(string: urlString) else { return }
//
//            do {
//                let response = AF.request(url, interceptor: .retryPolicy)
//                    .validate()
//                    .response
//                debugPrint(response)
////                switch response?.statusCode {
////                case 200:
////                    let decoder = JSONDecoder()
////                    do {
////                        let sunRadiationResponse = try decoder.decode(SunRadiationResponse.self, from: data)
////                        DispatchQueue.main.async {
////                            self.intervalIrradiance = sunRadiationResponse.irradiance.intervals
////                        }
////                    } catch {
////                        print("Failed to decode response: \(error)")
////                    }
////                case .failure(let error):
////                    print("Failed to fetch solar radiation data: \(error)")
////                }
//            } catch {
//                print("An error occurred: \(error)")
//            }
//        }
}



