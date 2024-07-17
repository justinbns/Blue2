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
    @Published var optimalDrying: OptimalDrying?
    @Published var isLoading : Bool = true
  
    private var weatherManager: WeatherManager = WeatherManager.shared
    
    @MainActor
    func getBestDryingTime(at location : CLLocation) async {
        let at = await weatherManager.getForecast(for: location, on: ForecastDay.today)
        let bestTime = await weatherManager.getBestDryingTime(at: at)
        
        if let best = bestTime {
            self.optimalDrying = best
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
            }
        }
    }
}

