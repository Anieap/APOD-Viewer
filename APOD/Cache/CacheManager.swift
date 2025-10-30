//
//  CacheManager.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

// MARK: - Cacheable

protocol Cacheable {
    func save<T: Encodable>(_ object: T, for key: String) async
    func load<T: Decodable>(_ type: T.Type, for key: String) async -> T?
    func clear() async
}

// MARK: - CacheManager

final class CacheManager: Cacheable {
    
    private let fileManager: FileManageable

    init(fileManager: FileManageable = FileManager.default) {
        self.fileManager = fileManager
    }

    private lazy var baseDirectory: URL = {
        let caches = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let directory = caches.appendingPathComponent("APODCache", isDirectory: true)
        try? self.fileManager.createDirectory(at: directory)
        return directory
    }()
    
    func save<T: Encodable>(_ object: T, for key: String) async {
        let fileURL = baseDirectory.appendingPathComponent(safeFileName(for: key))

        do {
            let data = try JSONEncoder().encode(object)
            try await Task.detached {
                try self.fileManager.write(data, to: fileURL, options: .atomic)
            }.value
        } catch {
            print("Failed to save data for key \(key):", error)
        }
    }
    
    func load<T: Decodable>(_ type: T.Type, for key: String) async -> T? {
        let fileURL = baseDirectory.appendingPathComponent(safeFileName(for: key))
        guard self.fileManager.fileExists(atPath: fileURL.path) else { return nil }

        return await Task.detached {
            do {
                let data = try self.fileManager.contentsOf(fileURL: fileURL)
                let object = try JSONDecoder().decode(T.self, from: data)
                return object
            } catch {
                print("Failed to load data for key \(key):", error)
                return nil
            }
        }.value
    }
    
    func clear() async {
        await Task.detached {
            guard let files = try? self.fileManager.contentsOfDirectory(at: self.baseDirectory) else { return }
            for file in files {
                try? self.fileManager.removeItem(at: file)
            }
        }.value
    }
    
    private func safeFileName(for key: String) -> String {
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "._-"))
        let safeString = key.unicodeScalars.map { allowedCharacters.contains($0) ? String($0) : "_" }.joined()
        return safeString
    }
}
