//
//  MockAPODService.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//
//  ⚠️ Note:
//  The APOD API is currently unavailable, so live data cannot be fetched at this time.
//  To preview the final output with data, `MockAPODService` loads sample responses
//  from a local JSON file (`apod_mock.json`). This mock will be removed once
//  the live APOD API is back online.

import Foundation

// MARK: - MockAPODService

final class MockAPODService: APODServiceProvider {
    func fetchAPOD(for date: Date?) async throws -> APODModel {
        let mockData = APODDataLoader.loadMockData()
        
        // Return an object that match the date
        if let date = date?.toString() {
            if let match = mockData.first(where: { $0.date == date }) {
                return match
            }
        }
        
        throw URLError(.unknown)
    }
}

// MARK: - APODDataLoader

extension MockAPODService {
    enum APODDataLoader {
        static func loadMockData() -> [APODModel] {
            guard let url = Bundle.main.url(forResource: "apod_mock", withExtension: "json") else {
                return []
            }

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                return try decoder.decode([APODModel].self, from: data)
            } catch {
                return []
            }
        }
    }
}
