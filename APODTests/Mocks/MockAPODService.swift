//
//  MockAPODService.swift
//  APODTests
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - MockAPODService

final class MockAPODService: APODServiceProvider {
    var shouldFailFetchAPOD = false
    
    func fetchAPOD(for date: Date?) async throws -> APOD.APODModel {
        if shouldFailFetchAPOD { throw URLError(.badServerResponse) }
        return APODModel.stub()
    }
}
