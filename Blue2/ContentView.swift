import SwiftUI

struct ContentView: View {
    @StateObject private var locationVM = LocationViewModel()
    
    var body: some View {
        ZStack {
            CurrentWeatherView()
            
            VStack {
                Spacer()
                    .frame(height: 350)
                ChooseDayView(location: locationVM.location)
                    
            }
        }
    }
}

#Preview {
    ContentView()
}
