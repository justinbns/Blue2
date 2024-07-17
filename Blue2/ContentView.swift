import SwiftUI

struct ContentView: View {
    @StateObject private var locationVM = LocationViewModel()
    
    var body: some View {
        ZStack (alignment: .bottom){
            CurrentWeatherView()
            
            VStack {
                Spacer()
                    .frame(height: 390)
                ChooseDayView(location: locationVM.location)
            }
        }
    }
}

#Preview {
    ContentView()
}
