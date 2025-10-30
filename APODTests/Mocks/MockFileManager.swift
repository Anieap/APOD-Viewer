//
//  MockFileManager.swift
//  APODTests
//
//  Created by Anie Parameswaran on 30/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - MockFileManager

final class MockFileManager: FileManageable {
    var urls: [URL] = [URL(fileURLWithPath: "mockPath")]
    var storedFiles: [URL: Data] = [:]
    var fileExists: Bool = true

    func urls(for directoay: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        self.urls
    }
    
    func createDirectory(at url: URL) throws {}
    
    func fileExists(atPath path: String) -> Bool {
        fileExists
    }
    
    func contentsOfDirectory(at url: URL) throws -> [URL] {
        storedFiles.keys.filter { $0 == url }
    }
    
    func removeItem(at url: URL) throws {
        storedFiles.removeValue(forKey: url)
    }

    func write(_ data: Data, to url: URL, options: Data.WritingOptions) throws {
        storedFiles[url] = data
    }

    func contentsOf(fileURL: URL) throws -> Data {
        storedFiles[fileURL] ?? Data()
    }
}
