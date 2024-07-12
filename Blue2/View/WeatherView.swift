//
//  WeatherView.swift
//  WiTher
//
//  Created by mac.bernanda on 11/07/24.
//
import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject private var weatherManager = WeatherManager()
    private let location = CLLocation(latitude: -6.302620705878877, longitude:  106.65203626737502) // Example coordinates
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TableView(title: "Today", forecast: weatherManager.todayForecast)
                    TableView(title: "Tomorrow", forecast: weatherManager.tomorrowForecast)
                    TableView(title: "Day After Tomorrow", forecast: weatherManager.dayAfterTomorrowForecast)
                }
                .navigationTitle("Forecast")
                .onAppear {
                    Task {
                        await weatherManager.getExtendedForecast(for: location)
                    }
                }
            }
        }
    }
}



#Preview {
    WeatherView()
}
