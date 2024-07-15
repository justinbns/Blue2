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
        ZStack {
            WeatherBackgroundView(condition: weatherViewModel.weatherCondition)
            VStack(alignment: .leading) {
                if let authorizationStatus = locationViewModel.authorizationStatus, authorizationStatus == .authorizedWhenInUse {
                    Text((locationViewModel.cityName))
                        .font(.custom("SF Pro", size: 16, relativeTo: .headline))
                        .foregroundStyle(.black)
                        .padding(.top, 77.5)
                        .padding(.leading, 10)
                    
                    Text(weatherViewModel.temperature)
                        .font(.custom("SF Pro", size: 32, relativeTo: .largeTitle))
                        .foregroundStyle(.black)
                        .padding(.leading, 10)
                } else {
                    Text("Error loading location")
                        .padding()
                }
                
                Spacer()
                
                HStack {
                    Button("Sunny") { weatherViewModel.weather = WeatherModel.mockSunny() }
                    Button("Sun + Cloud") { weatherViewModel.weather = WeatherModel.mockSunCloud() }
                    Button("Cloudy") { weatherViewModel.weather = WeatherModel.mockCloudy() }
                    Button("Rainy") { weatherViewModel.weather = WeatherModel.mockRainy() }
                    Button("Storm") { weatherViewModel.weather = WeatherModel.mockStorm() }
                }
                .padding()
            }
            .padding()
            .task {
                await weatherViewModel.fetchWeather(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
            }
            .onReceive(timer) { _ in
                Task {
                    await weatherViewModel.fetchWeather(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

