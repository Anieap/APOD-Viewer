//
//  MockCache.swift
//  APODTests
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - MockCache

final class MockCache: Cacheable {

    private var storage: [String: Data] = [:]
    
    func save<T: Encodable>(_ object: T, for key: String) async {
        if let encoded = try? JSONEncoder().encode(object) {
            storage[key] = encoded
        }
    }
    
    func load<T: Decodable>(_ type: T.Type, for key: String) async -> T? {
        guard let data = storage[key] else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func clear() async {
        self.storage.removeAll()
    }
}
