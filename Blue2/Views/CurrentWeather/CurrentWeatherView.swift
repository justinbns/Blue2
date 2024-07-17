//
//  CurrentWeatherView.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import SwiftUI

struct CurrentWeatherView<EmbeddedView: View>: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var locationViewModel : LocationViewModel
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    let embeddedView: EmbeddedView
    
    init(@ViewBuilder embeddedView: @escaping () -> EmbeddedView) {
        self.embeddedView = embeddedView()
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            WeatherBackgroundView(condition: weatherViewModel.weatherCondition)
            
            VStack(alignment: .leading) {
                if locationViewModel.authorizationStatus == .authorizedWhenInUse {
                    Text(locationViewModel.cityName)
                        .font(.custom("SF Pro", size: 16, relativeTo: .headline))
                        .foregroundStyle(.black)
                        .padding(.top, 85)
                        .padding(.leading, 20)
                    
                    Text(weatherViewModel.temperature)
                        .font(.custom("SF Pro", size: 32, relativeTo: .largeTitle))
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                }
                else {
                    Text("Unknown location")
                        .font(.custom("SF Pro", size: 16, relativeTo: .headline))
                        .foregroundStyle(.black)
                        .padding(.top, 85)
                        .padding(.leading, 20)
                    
                    Text("-")
                        .font(.custom("SF Pro", size: 32, relativeTo: .largeTitle))
                        .foregroundStyle(.black)
                        .padding(.leading, 20)
                }
                
                embeddedView
                Spacer()
            }
            .padding()
            .task {
                await fetchWeather()
            }
            .onReceive(timer) { _ in
                Task {
                    await fetchWeather()
                }
            }
        }
    }
    
    private func fetchWeather() async {
        await weatherViewModel.fetchWeather(at: locationViewModel.location)
    }
}

#Preview {
    ContentView()
}
