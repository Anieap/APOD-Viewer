//
//  StringExtensionTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 28/10/2025.
//

import Testing
@testable import APOD
import Foundation

// MARK: - StringExtensionTests

@Suite("String+Extension Tests")
struct StringExtensionTests {

    @Test("Parses valid yyyy-MM-dd string to Date", .tags(.extensions))
    func validDateString() throws {
        // Given
        let input = "2025-10-28"
        
        // When
        let result = input.toDate()
        
        // Then
        #expect(result != nil)
        
        let components = self.getComponents(from: result)
        #expect(components.year == 2025)
        #expect(components.month == 10)
        #expect(components.day == 28)
    }
        
    @Test("Returns nil for invalid date string format", .tags(.extensions))
    func invalidFormatReturnsNil() throws {
        // Given
        let input = "28-10-2025"
        
        // When
        let result = input.toDate()
        
        // Then
        #expect(result == nil)
    }
    
    @Test("Returns nil for non-date string", .tags(.extensions))
    func testNonsenseStringReturnsNil() throws {
        // Given
        let input = "hello test"
        
        // When
        let result = input.toDate()
        
        // Then
        #expect(result == nil)
    }
    
    @Test("Handles leap year date correctly", .tags(.extensions))
    func testLeapYearDate() throws {
        // Given
        let input = "2024-02-29"
        
        // When
        let result = input.toDate()
        
        // Then
        #expect(result != nil)
        
        let components = self.getComponents(from: result)
        #expect(components.year == 2024)
        #expect(components.month == 2)
        #expect(components.day == 29)
    }
}

extension StringExtensionTests {
    private func getComponents(from date: Date?) -> DateComponents {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.dateComponents([.year, .month, .day], from: date!)
    }
}
