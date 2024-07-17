//
//  ViewExtension.swift
//  Blue2
//
//  Created by mac.bernanda on 17/07/24.
//
import SwiftUI

extension View {
    func shimmering(active: Binding<Bool>) -> some View {
        self.overlay(
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.5), Color.clear]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .rotationEffect(.degrees(30))
                .offset(x: active.wrappedValue ? 500 : -500)
                .animation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false))
        )
    }
}
