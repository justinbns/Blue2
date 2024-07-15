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
        NavigationView {
            ScrollView {
                Text(weatherVM.cityName)
                VStack {
                    TableView(title: "Today", forecast: weatherVM.todayForecast)
                    TableView(title: "Tomorrow", forecast: weatherVM.tomorrowForecast)
                    TableView(title: "Day After Tomorrow", forecast: weatherVM.dayAfterTomorrowForecast)
                }
                .navigationTitle("Forecast")
                .onAppear {
                    Task {
                        await weatherVM.getTodayForecast()
                        await weatherVM.getTomorrowForecast()
                        await weatherVM.getDayAfterTomorrowForecast()
                    }
                }
            }
        }
    }
}



#Preview {
    WeatherView()
}
