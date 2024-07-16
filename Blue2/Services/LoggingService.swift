//
//  LoggerService.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import SwiftyBeaver
import Foundation

class LoggingService: LoggingProtocol {
    private let logger = SwiftyBeaver.self
    static let log = LoggingService()
    
    init() {
        let console = ConsoleDestination()
        let file = FileDestination()
        
        console.logPrintWay = .nslog
        console.format = "$DHH:mm:ss$d $L $M"
    
        logger.addDestination(console)
        logger.addDestination(file)
    }
    
    func info(_ message: Any) {
        logger.info("🟢 \(message)")
    }
    
    func debug(_ message: Any) {
        logger.debug("🟡 \(message)")
    }
    
    func error(_ message: Any) {
        logger.error("🔴 \(message)")
    }
    
//    func redirectConsoleLogToLoggingService() {
//        let pipe = Pipe()
//        dup2(pipe.fileHandleForWriting.fileDescriptor, fileno(stdout))
//        dup2(pipe.fileHandleForWriting.fileDescriptor, fileno(stderr))
//
//        // Handle reading from the pipe
//        pipe.fileHandleForReading.readabilityHandler = { handle in
//            let data = handle.availableData
//            if data.count > 0, let logMessage = String(data: data, encoding: .utf8) {
//                self.debug(logMessage.trimmingCharacters(in: .whitespacesAndNewlines))
//            }
//        }
//    }
}


