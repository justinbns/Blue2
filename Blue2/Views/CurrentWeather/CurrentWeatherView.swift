//
//  CurrentWeatherView.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @StateObject var locationViewModel = LocationViewModel()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // Update every 60 seconds
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            WeatherBackgroundView(condition: weatherViewModel.weatherCondition)
            VStack(alignment: .leading) {
                if let authorizationStatus = locationViewModel.authorizationStatus, authorizationStatus == .authorizedWhenInUse {
                    Text((locationViewModel.cityName))
                        .font(.custom("SF Pro", size: 16, relativeTo: .headline))
                        .foregroundStyle(.black)
                        .padding(.top, 85)
                        .padding(.leading, 20)
                    
                    Text(weatherViewModel.temperature)
                        .font(.custom("SF Pro", size: 32, relativeTo: .largeTitle))
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                    
                    BestTimeView(location: locationViewModel.location)
                        .padding([.top, .leading], 15)
                } else {
                    Text("Error loading location")
                        .padding()
                }
                Spacer()
            }
            .padding()
            .task {
                await weatherViewModel.fetchWeather(latitude: locationViewModel.location.coordinate.latitude, longitude: locationViewModel.location.coordinate.longitude)
            }
            .onReceive(timer) { _ in
                Task {
                    await weatherViewModel.fetchWeather(latitude: locationViewModel.location.coordinate.latitude, longitude: locationViewModel.location.coordinate.longitude)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
