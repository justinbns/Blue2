//
//  Day.swift
//  Weather
//
//  Created by Ferdinand Jacques on 09/07/24.
//

import SwiftUI
import CoreLocation

struct ChooseDayView: View {
    @State private var selected: String = "none"
    @State private var chosen: String = "none"
    @StateObject private var weatherManager = WeatherManager()
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            VStack {
                HStack(spacing: 0) {
                    ForEach(Array(weatherManager.forecastForNextThreeDays().enumerated()), id: \.element.day) { index, forecast in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selected = ["first", "second", "third"][index]
                                chosen = forecast.day
                                print(index, selected)
                            }
                        }) {
                            VStack(alignment: .center) {
                                Text(forecast.day)
                                    .font(.headline)
                                Image(systemName: forecast.symbol)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 125)
                            .padding(.vertical, 10)
                            .background(chosen == forecast.day ? Color.white : .chooseDay.opacity(0))
                            .foregroundColor(.black)
                            .cornerRadius(7)
                            .padding(chosen == forecast.day ? 5 : 0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: selected)
                        }
                    }
                }
                .background(.chooseDay.opacity(0.2))
                .cornerRadius(9)
                .padding()
                .task {
                    await weatherManager.getThreeDayForecast(for: CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude))
                }
            }
            .padding(.bottom, -20)
            if selected == "first" {
                TableView(selected: selected, forecast: weatherManager.todayForecast)
                    .transition(.slide.combined(with: .move(edge: .trailing)))
                    .animation(.easeInOut, value: selected)
                    .frame(width: .infinity, height: 200)
//                    .onAppear {
//                        Task {
//                            await weatherManager.getTodayForecast(for: CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude))
//                        }
//                    }
            } else if selected == "second" {
                TableView(selected: selected, forecast: weatherManager.tomorrowForecast)
                    .transition(.slide.combined(with: .move(edge: .trailing)))
                    .animation(.easeInOut, value: selected)
                    .frame(width: .infinity, height: 200)
//                    .onAppear {
//                        Task {
//                            await weatherManager.getTomorrowForecast()(for: CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude))
//                        }
//                    }
            } else if selected == "third" {
                TableView(selected: selected, forecast: weatherManager.dayAfterTomorrowForecast)
                    .transition(.slide.combined(with: .move(edge: .trailing)))
                    .animation(.easeInOut, value: selected)
                    .frame(width: .infinity, height: 200)
//                    .onAppear {
//                        Task {
//                            await weatherManager.getTheDayAfterTomorrowForecast(for: CLLocation(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude))
//                        }
//                    }
            }
        }
        else {
            Text("Error loading location")
                .padding()
        }
    }
}

#Preview {
    ChooseDayView()
}
