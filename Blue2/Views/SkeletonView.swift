//
//  SkeletonView.swift
//  Blue2
//
//  Created by mac.bernanda on 17/07/24.
//
import SwiftUI

struct ChooseDayViewSkeleton: View {
    @State private var pulse = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                ForEach(0..<3) { _ in
                    VStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 50, height: 20)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 125)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(7)
                    .padding(5)
                    .shimmering(active: $pulse)
                }
            }
            .background(Color.chooseDay)
            .cornerRadius(9)
            .padding()
            .padding(.bottom, 2)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: 250)
                .padding(.bottom, 75)
                .shimmering(active: $pulse)
        }
        .padding(16)
        .background(Color(.bestTime))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .onAppear {
            pulse.toggle()
        }
    }
}


struct BestTimeViewSkeleton: View {
    @State private var pulse = false
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 200, height: 20)
                .shimmering(active: $pulse)
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 36, height: 36)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 50)
            }
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 200, height: 20)
                .padding(.top, 6)
                .shimmering(active: $pulse)
        }.onAppear {
            pulse.toggle()
        }
    }
}

struct LocTempViewSkeleton: View {
    @State private var pulse = false
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 20)
                .padding(.top, 85)
                .padding(.leading, 20)
                .shimmering(active: $pulse)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 20, height: 40)
                .padding(.leading, 20)
                .shimmering(active: $pulse)
        }.onAppear {
            pulse.toggle()
        }
    }
}

#Preview {
    ContentView()
}
