//
//  MockImageFetchService.swift
//  APODTests
//
//  Created by Anie Parameswaran on 30/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - MockImageFetchService

final class MockImageFetchService: ImageFetchable {
    var shouldFailFetchImage = false
    
    func fetch(url: URL) async throws -> (Data, URLResponse) {
        if shouldFailFetchImage { throw URLError(.cannotLoadFromNetwork) }
        let response = URLResponse(
            url: url,
            mimeType: "image/jpeg",
            expectedContentLength: 0,
            textEncodingName: nil)
        return (Data([0x1, 0x2]), response)
    }
}

