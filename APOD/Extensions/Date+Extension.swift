//
//  Date+Extension.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

extension Date {
    /// Converts the date into a string using the provided date format.
    ///
    /// - Parameter format: The date format string. Defaults to `"yyyy-MM-dd"`.
    /// - Returns: A formatted date string.
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// Converts the date into a string using a custom date format.
    ///
    /// - Parameter format: A `DateFormatter`-compatible format string.
    /// - Returns: A formatted date string.
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
