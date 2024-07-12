//
//  EnvManager.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//

import Foundation

final class EnvManager {
    static let shared = EnvManager()
    @Published var API_KEY : String
    
    private init() {
//        let envDict = Bundle.main.infoDictionary?["LSEnvironment"] as! Dictionary<String, String>
        API_KEY = ""
    }
}
