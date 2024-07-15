//
//  WeatherConditiion.swift
//  Blue2
//
//  Created by Anthony on 15/07/24.
//

import SwiftUI

enum WeatherCondition {
    case sunny
    case sunCloud
    case cloudy
    case rainy
    case storm

    var gradient: Gradient {
            switch self {
            case .sunny:
                return Gradient(stops: [
                    .init(color: Color("C9E9F8"), location: 0),
                    .init(color: Color("FFFFFF"), location: 0.63)
                ])
            case .sunCloud:
                return Gradient(stops: [
                    .init(color: Color("C9E9F8").opacity(0.5), location: 0),
                    .init(color: Color("FFFFFF"), location: 0.63)
                ])
            case .cloudy:
                return Gradient(stops: [
                    .init(color: Color("CDE2F5"), location: 0),
                    .init(color: Color("FFFFFF"), location: 0.63)
                ])
            case .rainy:
                return Gradient(stops: [
                    .init(color: Color("ACC3E2"), location: 0),
                    .init(color: Color("FFFFFF"), location: 0.63)
                ])
            case .storm:
                return Gradient(stops: [
                    .init(color: Color("8BAAC6"), location: 0),
                    .init(color: Color("FFFFFF"), location: 0.63)
                ])
            }
    }

    @ViewBuilder
    var assets: some View {
        ZStack {
            
            switch self {
            case .sunny:
                Image("sunny_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                            
            // Commented out the previous sunny case code
            /*
            ZStack {
                Image("sun_outer_layer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 289, height: 289)
                    .position(x: UIScreen.main.bounds.width - 85, y: 10)
                                
                Image("sun_middle_layer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 231, height: 231)
                    .position(x: UIScreen.main.bounds.width - 70, y: 0)
                                
                Image("sun")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 167, height: 167)
                    .position(x: UIScreen.main.bounds.width - 55, y: -10)
            }
             */

            
            
            case .sunCloud:
                
                Image("suncloud_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            
//            ZStack{
//                    
//                Image("sun_outer_layer")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 289, height: 289)
//                    .position(x: UIScreen.main.bounds.width - 85, y: 10)
//                    
//                Image("sun_middle_layer")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 231, height: 231)
//                    .position(x: UIScreen.main.bounds.width - 70, y: 0)
//                    
//                Image("sun")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 167, height: 167)
//                    .position(x: UIScreen.main.bounds.width - 55, y: -10)
//                
//                Image("left_cloud_shadow")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 180, height: 125)
//                    .position(x: 80, y: -12)
//                
//                Image("left_cloud")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 180, height: 125)
//                    .position(x: 76, y: -20)
//                
//                Image("right_cloud")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 203, height: 133)
//                    .position(x: UIScreen.main.bounds.width - 68, y: 55)
//                        
//            }
            
            case .cloudy:
                
                Image("cloudy_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
//                ZStack{
//                    
//                    Image("wide_cloud_shadow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 471, height: 139)
//                        .position(x: UIScreen.main.bounds.width / 2, y: 0)
//                    
//                    Image("wide_cloud")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 470, height: 142)
//                        .position(x: UIScreen.main.bounds.width / 2, y: -10)
//                }
//               
           
            case .rainy:
                
                Image("rainy_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
//                ZStack{
//                    
//                    Image("rain")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 366, height: 262)
//                        .position(x: UIScreen.main.bounds.width / 2 - 5, y: 118)
//                        .foregroundColor(.white)
//                    
//                    Image("wide_dark_cloud_shadow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 471, height: 139)
//                        .position(x: UIScreen.main.bounds.width / 2, y: 0)
//                    
//                    Image("wide_dark_cloud")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 470, height: 142)
//                        .position(x: UIScreen.main.bounds.width / 2, y: -10)
//                }
                
            case .storm:
               
                Image("storm_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
//                ZStack{
//                    
//                    Image("rain")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 366, height: 262)
//                        .position(x: UIScreen.main.bounds.width / 2 - 5, y: 118)
//                        .foregroundColor(.white)
//                    
//                    Image("wide_stormy_cloud_shadow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 471, height: 139)
//                        .position(x: UIScreen.main.bounds.width / 2, y: 0)
//                    
//                    Image("wide_stormy_cloud")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 470, height: 142)
//                        .position(x: UIScreen.main.bounds.width / 2, y: -10)
//                    
//                    Image("lightning")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 224, height: 100)
//                        .position(x: UIScreen.main.bounds.width - 120, y: 60)
//                }
//                
            }
//            
//            ZStack{
//                Image("dark_green_land")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 431, height: 75)
//                    .position(x: UIScreen.main.bounds.width / 2 + 37, y: UIScreen.main.bounds.height / 2 - 145)
//                
//                Image("green_land")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 431, height: 77)
//                    .position(x: UIScreen.main.bounds.width / 2 + 35, y: UIScreen.main.bounds.height / 2 - 150)
//                
//            }
        }
    }
}


