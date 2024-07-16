//
//  GradientBackgroundView.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color("C9E9F8"), location: 0),
                .init(color: Color("FFFFFF"), location: 0.63)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}
