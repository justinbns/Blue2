//
//  Blue2App.swift
//  Blue2
//
//  Created by Justin Jefferson on 10/07/24.
//

import SwiftUI

@main
struct Blue2App: App {
    init() {
        LoggingService.log.info("Application is starting!")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
