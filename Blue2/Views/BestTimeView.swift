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
    @StateObject private var bestTimeVM = BestTimeViewModel()
    @EnvironmentObject var locationVM : LocationViewModel
    
    var body: some View {
        ZStack {
            if bestTimeVM.isLoading { BestTimeViewSkeleton() }
            else {
                if let optimalDrying = bestTimeVM.optimalDrying {
                    VStack(alignment: .leading) {
                        Text("**Today** best drying time")
                            .font(.system(size: 15))
                            .font(.title3)
                        HStack {
                            Image(systemName: "clock")
                                .font(.system(size: 24))
                            Text("\(DateUtil.formatDateToStringTime(optimalDrying.date))")
                                .fontWeight(.bold)
                                .font(.system(size: 40))
                        }
                        Text("Approximately dry at ")
                            .font(.system(size: 15)) +
                        Text("\(dryAt(date: optimalDrying.date, dryingTimeInMinutes: optimalDrying.dryingTimeInMinutes))")
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .padding(16)
        .background(Color(.bestTime))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .task {
            await bestTimeVM.getBestDryingTime(at: locationVM.location)
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

#Preview {
    ContentView()
}

