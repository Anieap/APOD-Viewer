//
//  DateExtensionTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 28/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - DateExtensionTests

@Suite("Date+Extension Tests")
struct DateExtensionTests {

    @Test("shoulld returns yyyy-MM-dd formatted string", .tags(.extensions))
    func toString() throws {
        // Given
        let components = DateComponents(year: 2025, month: 10, day: 28)
        let date = Calendar(identifier: .gregorian).date(from: components)!
        
        // When
        let result = date.toString()
        
        // Then
        #expect(result == "2025-10-28")
    }
        
    @Test("should returns custom format string", .tags(.extensions))
    func formatted() throws {
        // Given
        let components = DateComponents(year: 2025, month: 1, day: 5, hour: 15, minute: 30)
        let date = Calendar(identifier: .gregorian).date(from: components)!
        
        // When
        let formatted = date.formatted("MMM d, yyyy")
        
        // Then
        #expect(formatted == "Jan 5, 2025")
    }

}
