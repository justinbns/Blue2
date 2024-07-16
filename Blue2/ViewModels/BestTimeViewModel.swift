//
//  BestTimeViewModel.swift
//  Blue2
//
//  Created by Vincent Junior Halim on 16/07/24.
//

import Foundation
import Combine
import WeatherKit
import CoreLocation

class BestTimeViewModel: ObservableObject {
    let location : CLLocation
    @Published var optimalDrying: OptimalDrying = OptimalDrying(date: .now, dryingTimeInMinutes: 0)
  
    private var weatherManager: WeatherManager = WeatherManager.shared
    
    init(location: CLLocation) {
        self.location = location
    }
    
    @MainActor
    func getBestDryingTime() async {
        let at = await weatherManager.getTodayForecast(for: location)
        let bestTime = await weatherManager.getBestDryingTime(at: at)
        
        if let best = bestTime {
            LoggingService.log.info("nilai \(best)")
            self.optimalDrying = best
        }
    }
}

