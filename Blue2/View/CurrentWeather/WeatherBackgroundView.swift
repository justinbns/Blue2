//
//  WeatherBackgroundView.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import SwiftUI

struct WeatherBackgroundView: View {
    var condition: WeatherCondition

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: condition.gradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            condition.assets
        }
    }
}


