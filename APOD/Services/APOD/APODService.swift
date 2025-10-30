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
    
    init(session: NetworkSession = URLSession.shared, apiKey: String = "DEMO_KEY") {
        self.session = session
        self.apiKey = apiKey
    }
    
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
