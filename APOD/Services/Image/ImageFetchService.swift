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
    
    /// Fetches image data from the given URL asynchronously.
    ///
    /// - Parameter url: The URL of the image to fetch.
    /// - Returns: A tuple containing the fetched `Data` and `URLResponse`.
    /// - Throws: Propagates any error from the underlying network session.
    func fetch(url: URL) async throws -> (Data, URLResponse) {
        try await session.data(from: url)
    }
}
