//
//  Day.swift
//  Weather
//
//  Created by Ferdinand Jacques on 09/07/24.
//

import SwiftUI
import CoreLocation

struct ChooseDayView: View {
    @StateObject var chooseDayVM = ChooseDayViewModel()
    @EnvironmentObject var locationVM : LocationViewModel
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    ForEach(Array(chooseDayVM.threeDayForecast.enumerated()), id: \.element.day) { index, forecast in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                chooseDayVM.selected = [.today, .tomorrow, .dayAfterTomorrow][index]
                                chooseDayVM.chosen = forecast.day

                            }
                        }) {
                            VStack(alignment: .center) {
                                if index == 0 {
                                    Text("Today")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(Color.text)
                                } else {
                                    Text(forecast.day)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(Color.text)
                                }
                                Image(systemName: forecast.symbol)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.text)
                            }
                            .frame(width: 125)
                            .padding(.vertical, 10)
                            .background(chooseDayVM.chosen == forecast.day ? Color.selected : Color.chooseDay.opacity(0))
                            .cornerRadius(7)
                            .padding(chooseDayVM.chosen == forecast.day ? 5 : 0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: chooseDayVM.selected)
                        }
                    }
                }
                .background(Color.chooseDay)
                .cornerRadius(9)
                .padding()
                .padding(.bottom, 2)
                
                TableView(forecast: chooseDayVM.forecast)
                .transition(.opacity)
                .animation(.easeInOut, value: chooseDayVM.selected)
                .frame(width: .infinity, height: 250)
                .padding(.bottom, 75)
                .onAppear {
                    Task {
                        await chooseDayVM.getForecast(at: locationVM.location, on: .today)
                    }
                }
                .onChange(of: chooseDayVM.selected) {
                    Task {
                        await chooseDayVM.getForecast(at: locationVM.location, on: chooseDayVM.selected)
                    }
                }

                
//                if chooseDayVM.selected == "first" {
//                    TableView(selected: chooseDayVM.selected, forecast: chooseDayVM.todayForecast)
//                        .transition(.opacity)
//                        .animation(.easeInOut, value: chooseDayVM.selected)
//                        .frame(width: .infinity, height: 250)
//                        .padding(.bottom, 75)
//                        .task {
//                            await chooseDayVM.getForecast(at: locationVM.location, on: .today)
//                        }
//                } else if chooseDayVM.selected == "second" {
//                    TableView(selected: chooseDayVM.selected, forecast: chooseDayVM.tomorrowForecast)
//                        .transition(.opacity)
//                        .animation(.easeInOut, value: chooseDayVM.selected)
//                        .frame(width: .infinity, height: 250)
//                        .padding(.bottom,75)
//                        .task {
//                            await chooseDayVM.getForecast(at: locationVM.location, on: .tomorrow)
//                        }
//                } else if chooseDayVM.selected == "third" {
//                    TableView(selected: chooseDayVM.selected, forecast: chooseDayVM.dayAfterTomorrowForecast)
//                        .transition(.opacity)
//                        .animation(.easeInOut, value: chooseDayVM.selected)
//                        .frame(width: .infinity, height: 250)
//                        .padding(.bottom,75)
//                        .task {
//                            await chooseDayVM.getForecast(at: locationVM.location, on: .dayAfterTomorrow)
//                        }
//                }
                
            }
            Color(Color.base)
                .zIndex(-1000)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .onAppear {
            Task {
                await chooseDayVM.getThreeDayForecast(for: locationVM.location)
            }
        }
    }
}

#Preview{
    ContentView()
}
