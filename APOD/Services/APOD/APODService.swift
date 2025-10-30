//
//  APODService.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

// MARK: - APODServiceProvider

protocol APODServiceProvider {
    func fetchAPOD(for date: Date?) async throws -> APODModel
}

// MARK: - APODService

final class APODService: APODServiceProvider {
    
    private let session: NetworkSession
    private let apiKey: String
    private let baseURL = "https://api.nasa.gov/planetary/apod"
    
    /// Initializes a new instance of `APODService`.
    ///
    /// - Parameters:
    ///   - session: The network session to use. Defaults to `URLSession.shared`.
    ///   - apiKey: The NASA API key. Defaults to `"DEMO_KEY"` (rate-limited).
    init(session: NetworkSession = URLSession.shared, apiKey: String = "DEMO_KEY") {
        self.session = session
        self.apiKey = apiKey
    }
    
    /// Fetches NASA’s Astronomy Picture of the Day (APOD) for a given date.
    ///
    /// This method constructs a URL with the API key and optional `date` parameter,
    /// performs the network call asynchronously, and decodes the response into
    /// an `APODModel`.
    ///
    /// - Parameter date: The date for which to fetch the APOD.
    ///   If `nil`, a random APOD is retrieved.
    /// - Returns: A decoded `APODModel` instance containing APOD details.
    /// - Throws: error for failures
    func fetchAPOD(for date: Date?) async throws -> APODModel {
        var components = URLComponents(string: baseURL)
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "count", value: String(1))
        ]
        
        if let date {
            queryItems.append(URLQueryItem(name: "date", value: date.toString()))
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        
        let model = try JSONDecoder().decode(APODModel.self, from: data)
        return model
    }
}
