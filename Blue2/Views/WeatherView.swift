//
//  WeatherView.swift
//  WiTher
//
//  Created by mac.bernanda on 11/07/24.
//
import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        VStack {
//            Text(weatherVM.cityName)
            ChooseDayView(location: weatherVM.location)
        }
        
    }
}



#Preview {
    WeatherView()
}
