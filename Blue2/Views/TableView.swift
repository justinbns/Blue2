//
//  TableView.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//

import SwiftUI

struct TableView: View {
    let selected: String
    let forecast: [WeatherTableData]
    
    var body: some View {
        List {
            Section(header:
                HStack {
                    Text("Start Drying")
                        .frame(maxWidth: 100, alignment: .center)
                        .foregroundColor(Color.text)
                    Text("")
                        .frame(maxWidth: 110, alignment: .center)
                        .foregroundColor(Color.text)
                    Text("Drying Duration")
                        .frame(maxWidth: 140, alignment: .center)
                        .foregroundColor(Color.text)
                }
                .frame(height: 30)
                .listRowBackground(Color.base)
                .font(.headline)
            ) {
                ForEach(forecast, id: \.date) { weather in
                    HStack {
                        Text(weather.date, style: .time)
                            .frame(maxWidth: 100, alignment: .center)
                            .foregroundColor(Color.text)
                        HStack(spacing: 0) {
                            Image(systemName: weather.symbolname)
                                .frame(maxWidth: 55, alignment: .trailing)
                                .foregroundColor(Color.text)
                            Spacer().frame(width: 0)
                            Text("\(weather.temperature.value, specifier: "%.0f")°")
                                .frame(maxWidth: 55, alignment: .center)
                                .foregroundColor(Color.text)
                        }
                        Text("\(weather.dryingTime.hrs) hrs \(weather.dryingTime.min) min")
                                    .frame(maxWidth: 140, alignment: .center)
                                    .foregroundColor(Color(weather.dryingTime.color))
                    }
                    .listRowBackground(Color.base)
                }
            }
        }
        .padding([.leading], 10)
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
}
