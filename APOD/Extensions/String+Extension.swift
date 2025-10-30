//
//  String+Extension.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

extension String {
    /// Converts a "yyyy-MM-dd" formatted string to a Date.
    /// Returns `nil` if parsing fails.
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
