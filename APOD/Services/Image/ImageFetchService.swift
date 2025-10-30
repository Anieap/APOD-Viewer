//
//  ImageFetchService.swift
//  APOD
//
//  Created by Anie Parameswaran on 30/10/2025.
//

import Foundation

// MARK: - ImageFetchable

protocol ImageFetchable {
    func fetch(url: URL) async throws -> (Data, URLResponse)
}

// MARK: - ImageFetchService

final class ImageFetchService: ImageFetchable {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(url: URL) async throws -> (Data, URLResponse) {
        try await session.data(from: url)
    }
}
