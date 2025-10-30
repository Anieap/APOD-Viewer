//
//  APODServiceTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Testing
@testable import APOD
import Foundation

// MARK: - APODServiceTests

@Suite("APODService Tests")
struct APODServiceTests {

    @Test("returns decoded model when fetchAPOD succeeds", .tags(.apodService))
    func fetchAPODSuccess() async throws {
        // Given
        let sut = makeSUT()
        let expectedModel = APODModel.stub()
        sut.session.data = try JSONEncoder().encode(expectedModel)
        
        // When
        let result = try await sut.service.fetchAPOD(for: Date())
        
        // Then
        #expect(result.title == expectedModel.title)
        #expect(result.date == expectedModel.date)
    }
    
    @Test("Throws an error when the fetchAPOD fails", .tags(.apodService))
    func throwErrorIfFetchAPODFails() async throws {
        // Given
        let sut = makeSUT()
        let expectedError = URLError(.badServerResponse)
        sut.session.error = expectedError
        
        // When/Then
        await #expect(throws: expectedError) {
            _ = try await sut.service.fetchAPOD(for: Date())
        }
    }
}

// MARK: - SUT

extension APODServiceTests {
    private typealias SUT = (session: MockNetworkSession, service: APODService)
    private func makeSUT() -> SUT {
        let session = MockNetworkSession()
        let service = APODService(session: session, apiKey: "TEST_KEY")
        return (session, service)
    }
}
