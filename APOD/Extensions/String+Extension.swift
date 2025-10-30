//
//  String+Extension.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

extension String {
    /// Converts a date string into a `Date` object using the specified format.
    ///
    /// - Parameter format: The date format pattern used to parse the string.
    ///   Defaults to `"yyyy-MM-dd"`.
    /// - Returns: A `Date` if the string can be parsed; otherwise, `nil`.
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
