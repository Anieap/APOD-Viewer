//
//  FileManageable.swift
//  APOD
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Foundation

// MARK: - FileManageable

protocol FileManageable {
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    func createDirectory(at url: URL) throws
    func fileExists(atPath path: String) -> Bool
    func contentsOfDirectory(at url: URL) throws -> [URL]
    func removeItem(at url: URL) throws
    func write(_ data: Data, to url: URL, options: Data.WritingOptions) throws
    func contentsOf(fileURL: URL) throws -> Data
}

extension FileManager: FileManageable {
    func createDirectory(at url: URL) throws {
        try self.createDirectory(at: url, withIntermediateDirectories: true)
    }
    
    func contentsOfDirectory(at url: URL) throws -> [URL] {
        try self.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
    }

    func write(_ data: Data, to url: URL, options: Data.WritingOptions) throws {
        try data.write(to: url, options: options)
    }

    func contentsOf(fileURL: URL) throws -> Data {
        try Data(contentsOf: fileURL)
    }
}
