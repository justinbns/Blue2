//
//  TableView.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//

import SwiftUI

struct TableView: View {
    let title: String
    let forecast: [WeatherTableData]
    
    var body: some View {
        Section(header: Text(title)) {
            VStack(alignment: .leading, spacing: 10) {
                // Table Header
                HStack {
                    Text("Time")
                        .frame(width: 80, alignment: .leading)
                    Text("Temp")
                        .frame(width: 80, alignment: .leading)
//                    Text("RH")
//                        .frame(width: 80, alignment: .leading)
                    Text("ghi")
                        .frame(width: 80, alignment: .leading)
                    Text("DryingTime")
                        .frame(width: 80, alignment: .leading)
                   
                }
                .font(.headline)
                .padding(.bottom, 5)
                
                // Table Rows
                ForEach(forecast, id: \.date) { weather in
                    HStack {
                        Text(weather.date, style: .time)
                            .frame(width: 80, alignment: .leading)
                        Text("\(weather.temperature.value, specifier: "%.1f")°")
                            .frame(width: 80, alignment: .leading)
//                        Text("\(weather.humidity * 100, specifier: "%.0f")%")
//                            .frame(width: 80, alignment: .leading)
                        Text("\(weather.ghi, specifier: "%.0f")")
                            .frame(width: 80, alignment: .leading)
                        Text("\(weather.dryingTime!, specifier: "%.1f") hrs(s)")
                            .frame(width: 80, alignment: .leading)
                    }
                    Divider() // Divider between rows
                }
            }
            .padding()
        }
    }
}
