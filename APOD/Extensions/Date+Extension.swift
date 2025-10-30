//
//  Date+Extension.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

extension Date {
    /// Converts a Date to a "yyyy-MM-dd" formatted string
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
