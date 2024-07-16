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
            HStack {
                Text("Start Drying")
                    .frame(maxWidth: 100, alignment: .center)
                    .foregroundColor(.black)
                Text("")
                    .frame(maxWidth: 110, alignment: .center)
                    .foregroundColor(.black)
                Text("Drying Duration")
                    .frame(maxWidth: 140, alignment: .center)
                    .foregroundColor(.black)
            }
            .listRowBackground(Color.white)
            .font(.headline)
            ForEach(forecast, id: \.date) { weather in
                HStack {
                    Text(weather.date, style: .time)
                        .frame(maxWidth: 100, alignment: .center)
                        .foregroundColor(.black)
                    HStack(spacing: 0) {
                        Image(systemName: weather.symbolname)
                            .frame(maxWidth: 55, alignment: .trailing)
                            .foregroundColor(.black)
                        Spacer().frame(width: 0)
                        Text("\(weather.temperature.value, specifier: "%.0f")°")
                            .frame(maxWidth: 55, alignment: .center)
                            .foregroundColor(.black)
                    }
                    Text(weather.dryingTime[2])
                        .frame(maxWidth: 140, alignment: .center)
                        .foregroundColor(stringToColor(colorString: weather.dryingTime[1]))
                }
            }
            .listRowBackground(Color.white)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
}
