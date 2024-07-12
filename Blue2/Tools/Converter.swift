//
//  Converter.swift
//  Blue2
//
//  Created by mac.bernanda on 12/07/24.
//

import Foundation

func formatDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}
