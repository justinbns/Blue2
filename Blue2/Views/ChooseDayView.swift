//
//  Day.swift
//  Weather
//
//  Created by Ferdinand Jacques on 09/07/24.
//

import SwiftUI
import CoreLocation

struct ChooseDayView: View {
    @StateObject private var chooseDayVM: ChooseDayViewModel
    
    init(location: CLLocation) {
        _chooseDayVM = StateObject(wrappedValue: ChooseDayViewModel(location: location))
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(Array(chooseDayVM.threeDayForecast.enumerated()), id: \.element.day) { index, forecast in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            chooseDayVM.selected = ["first", "second", "third"][index]
                            chooseDayVM.chosen = forecast.day
                            LoggingService.log.info("\(index), \(chooseDayVM.selected)")
                        }
                    }) {
                        VStack(alignment: .center) {
                            if index == 0 {
                                Text("Today")
                                    .font(.headline)
                            } else {
                                Text(forecast.day)
                                    .font(.headline)
                            }
                            Image(systemName: forecast.symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                        .frame(width: 125)
                        .padding(.vertical, 10)
                        .background(chooseDayVM.chosen == forecast.day ? Color.white : .chooseDay.opacity(0))
                        .foregroundColor(.black)
                        .cornerRadius(7)
                        .padding(chooseDayVM.chosen == forecast.day ? 5 : 0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: chooseDayVM.selected)
                    }
                }
            }
            .background(.chooseDay.opacity(0.2))
            .cornerRadius(9)
            .padding()
        }
        .padding(.bottom, -20)
        .onAppear {
            Task {
                await chooseDayVM.getThreeDayForecast()
            }
        }
        
        if chooseDayVM.selected == "first" {
            TableView(selected: chooseDayVM.selected, forecast: chooseDayVM.todayForecast)
                .transition(.slide.combined(with: .move(edge: .trailing)))
                .animation(.easeInOut, value: chooseDayVM.selected)
                .frame(width: .infinity, height: 200)
                .task {
                    await chooseDayVM.getTodayForecast()
                }
        } else if chooseDayVM.selected == "second" {
            TableView(selected: chooseDayVM.selected, forecast: chooseDayVM.tomorrowForecast)
                .transition(.slide.combined(with: .move(edge: .trailing)))
                .animation(.easeInOut, value: chooseDayVM.selected)
                .frame(width: .infinity, height: 200)
                .task {
                    await chooseDayVM.getTomorrowForecast()
                }
        } else if chooseDayVM.selected == "third" {
            TableView(selected: chooseDayVM.selected, forecast: chooseDayVM.dayAfterTomorrowForecast)
                .transition(.slide.combined(with: .move(edge: .trailing)))
                .animation(.easeInOut, value: chooseDayVM.selected)
                .frame(width: .infinity, height: 200)
                .task {
                    await chooseDayVM.getDayAfterTomorrowForecast()
                }
        }
    }
    
    
}


