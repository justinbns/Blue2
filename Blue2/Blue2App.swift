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
        LoggingService.log.info("App Started!")
//        LoggingService.log.redirectConsoleLogToLoggingService()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
