//
//  MockNetworkSession.swift
//  APODTests
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - MockNetworkSession

final class MockNetworkSession: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    private(set) var url: URL?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        self.url = url
        
        if let error = error {
            throw error
        }
        
        return (data ?? Data(), response ?? URLResponse())
    }
}

