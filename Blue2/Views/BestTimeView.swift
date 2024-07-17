//
//  BestTimeView.swift
//  Blue2
//
//  Created by Vincent Junior Halim on 16/07/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct BestTimeView: View {
    @StateObject private var bestTimeVM : BestTimeViewModel
    
    init(location: CLLocation) {
        _bestTimeVM = StateObject(wrappedValue: BestTimeViewModel(location: location))
    }
    
    var body: some View {
        ZStack{
            VStack(alignment:.leading){
                Text("**Today** best drying time")
                    .font(.system(size: 15))
                    .font(.title3)
                HStack{
                    Image(systemName: "clock")
                        .font(.system(size: 24))
                    Text("\(DateUtil.formatDateToStringTime(bestTimeVM.optimalDrying.date))")
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                }
                Text("Approximately dry at ")
                    .font(.system(size: 15)) +
                Text("\(dryAt(date: bestTimeVM.optimalDrying.date, dryingTimeInMinutes: bestTimeVM.optimalDrying.dryingTimeInMinutes))")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }.padding(16)
            .background(Color(.bestTime))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
            .task {
                await bestTimeVM.getBestDryingTime()
            }
    }
    
    func dryAt(date:Date, dryingTimeInMinutes: Int)->String{
        var dateComponents = DateComponents()
        dateComponents.minute = dryingTimeInMinutes
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: dateComponents, to: date) {
            return DateUtil.formatDateToStringTime(newDate)
        } else {
            return DateUtil.formatDateToStringTime(date)
        }
    }
}

