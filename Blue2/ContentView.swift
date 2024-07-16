import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CurrentWeatherView()
            VStack {
                Spacer()
                WeatherView()
                    .padding(.bottom, 130)
            }
        }
    }
}

#Preview {
    ContentView()
}
