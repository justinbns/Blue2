//
//  EnvManager.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//

import Foundation

final class EnvManager {
    static let shared = EnvManager()
    @Published var API_KEY : String = ""
    
    private init() {
        guard let envDict = Bundle.main.infoDictionary?["LSEnvironment"] as? [String: String] else {
            self.API_KEY = ""
            LoggingService.log.error("Failed to retrieve LSEnvironment from infoDictionary or it is nil.")
            return
        }
        
        API_KEY = envDict["API_KEY"] ?? ""
    }
}
