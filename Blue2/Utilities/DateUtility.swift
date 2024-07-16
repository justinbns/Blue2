//
//  DateUtilites.swift
//  Blue2
//
//  Created by mac.bernanda on 15/07/24.
//
import Foundation



class DateUtil {
    static func getTomorrow() -> Date {
        let calendar = Calendar.current
        let tomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400))
        
        return tomorrow
    }
    
    static func getTheDayAfterTomorrow() -> Date {
        let calendar = Calendar.current
        let theDayAfterTomorrow = calendar.startOfDay(for: Date().addingTimeInterval(86400 * 2))
        
        return theDayAfterTomorrow
    }
    
    static func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateToDayOfWeek(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
    
    
}
