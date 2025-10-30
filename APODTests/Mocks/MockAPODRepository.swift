//
//  MockAPODRepository.swift
//  APODTests
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - MockAPODRepository

final class MockAPODRepository: APODRepositoryProtocol {
    var shouldFailFetch = false
    var shouldFailCachedFetch = false
    var shouldFailImageFetch = false
    var fetchImageCalled = false
    
    func fetchAPOD(for date: Date) async throws -> APOD.APODModel {
        if shouldFailFetch { throw URLError(.badServerResponse) }
        
        return APODModel.stub()
    }
    
    func fetchCachedAPOD(for key: String) async throws -> APOD.APODModel? {
        if shouldFailCachedFetch { throw URLError(.fileDoesNotExist) }
        
        return APODModel.stub(title: "Cached APOD")
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        self.fetchImageCalled = true
        if shouldFailImageFetch { throw URLError(.cannotLoadFromNetwork) }
        return Data()
    }
}

