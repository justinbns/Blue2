import SwiftUI

struct ContentView: View {
    @StateObject private var locationVM = LocationViewModel()
    
    var body: some View {
        ZStack (alignment: .bottom) {
            CurrentWeatherView {
                
                BestTimeView()
                    .environmentObject(locationVM)
                    .padding([.top, .leading], 15)
                
            }.environmentObject(locationVM)
            
            VStack {
                Spacer().frame(height: 390)
                ChooseDayView().environmentObject(locationVM)
            }
        }
    }
}

#Preview {
    ContentView()
}
