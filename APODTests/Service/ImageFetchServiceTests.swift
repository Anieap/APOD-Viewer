//
//  ImageFetchServiceTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 30/10/2025.
//

import Testing
@testable import APOD
import Foundation

// MARK: - ImageFetchServiceTests

@Suite("ImageFetchService Tests")
struct ImageFetchServiceTests {

    @Test("Ensures the correct URL is used and data is returned", .tags(.imageFetchService))
    func fetchUrlSuccess() async throws {
        // Given
        let sut = makeSUT()
        let url = URL(string: "https://example.com")!
        let expectedData = Data([0x1, 0x2])
        sut.session.data = expectedData
        
        // When
        let (data, _) = try await sut.service.fetch(url: url)
        
        // Then
        #expect(sut.session.url == url)
        #expect(data == expectedData)
    }
    
    @Test("Throws an error when the fetch fails", .tags(.imageFetchService))
    func fetchUrlFailThrowsError() async throws {
        // Given
        let sut = makeSUT()
        let url = URL(string: "https://example.com")!
        let expectedError = URLError(.badURL)
        sut.session.error = expectedError
        
        // When/Then
        await #expect(throws: expectedError) {
            _ = try await sut.service.fetch(url: url)
        }
    }
}

// MARK: - SUT

extension ImageFetchServiceTests {
    private typealias SUT = (session: MockNetworkSession, service: ImageFetchService)
    private func makeSUT() -> SUT {
        let session = MockNetworkSession()
        let service = ImageFetchService(session: session)
        return (session, service)
    }
}
