//
//  CacheManagerTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Testing
@testable import APOD
import Foundation

// MARK: - CacheManagerTests

@Suite("CacheManager Tests")
struct CacheManagerTests {

    @Test("Cache should save successfully", .tags(.cacheManager))
    func cachedSuccessfully() async throws {
        // Given
        let sut = makeSUT()
        let model = APODModel.stub()
        let key = "Mock_Key"
        let fileUrl = URL(fileURLWithPath: "mockPath/APODCache/").appendingPathComponent(key)

        // When
        await sut.cache.save(model, for: key)

        // Then
        guard let data = sut.manager.storedFiles[fileUrl] else { return }
        let returnedModel = try JSONDecoder().decode(APODModel.self, from: data)
        #expect(model.title == returnedModel.title)
        #expect(model.date == returnedModel.date)
    }

    @Test("Cache should load successfully", .tags(.cacheManager))
    func cacheLoadedSuccessfully() async throws {
        // given
        let sut = makeSUT()
        let model = APODModel.stub()
        let key = "Mock_Key"
        let fileUrl = URL(fileURLWithPath: "mockPath/APODCache/").appendingPathComponent(key)
        let data = try JSONEncoder().encode(model)
        sut.manager.storedFiles[fileUrl] = data

        // when
        let result = await sut.cache.load(APODModel.self, for: key)

        // then
        #expect(model.title == result?.title)
        #expect(model.date == result?.date)
    }

    @Test("Should return nil when passing a non-existing key", .tags(.cacheManager))
    func tryToLoadNonCachedItemReturnsNil() async throws {
        // Given
        let sut = makeSUT()
        let model = APODModel.stub()
        let key = "Mock_Key"
        let fileUrl = URL(fileURLWithPath: "mockPath/APODCache/").appendingPathComponent(key)
        let data = try JSONEncoder().encode(model)
        sut.manager.storedFiles[fileUrl] = data

        // when
        let result = await sut.cache.load(APODModel.self, for: "Wrong_Key")
        
        // Then
        #expect(result == nil)
    }
    
    @Test("Clear should remove all cached items", .tags(.cacheManager))
    func clearRemovesAllFiles() async throws {
        // Given
        let sut = makeSUT()
        let model = APODModel.stub()
        let fileUrl = URL(fileURLWithPath: "mockPath").appendingPathComponent("APODCache", isDirectory: true)
        let data = try JSONEncoder().encode(model)
        sut.manager.storedFiles[fileUrl] = data

        // When
        await sut.cache.clear()
        
        // Then
        #expect(sut.manager.storedFiles.isEmpty)
    }

    @Test("Special characters in the key should be replaced", .tags(.cacheManager))
    func specialCharactersInKeyAreReplaced() async throws {
        // Given
        let sut = makeSUT()
        let model = APODModel.stub()
        let key = "Mock%Key&"

        // When
        await sut.cache.save(model, for: key)

        // Then
        let path = sut.manager.storedFiles.keys.first?.path
        #expect(path == "/mockPath/APODCache/Mock_Key_")
    }
}

// MARK: - SUT

extension CacheManagerTests {
    private typealias SUT = (manager: MockFileManager, cache: CacheManager)
    private func makeSUT() -> SUT {
        let manager = MockFileManager()
        let cache = CacheManager(fileManager: manager)
        return (manager, cache)
    }
}
