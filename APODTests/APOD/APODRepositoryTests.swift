//
//  APODRepositoryTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 28/10/2025.
//

import Testing
@testable import APOD
import Foundation

// MARK: - APODRepositoryTests

@Suite("APODRepository Tests")
struct APODRepositoryTests {

    @Test("Fetches APOD successfully and caches it", .tags(.apodRepository))
    func fetchAPODSuccess() async throws {
        // Given
        let sut = self.makeSUT()
        
        // When
        let result = try await sut.repo.fetchAPOD(for: Date())
        
        // Then
        #expect(result.title == "Mock APOD")
        
        let cached = await sut.cache.load(APODModel.self, for: "last_apod")
        #expect(cached != nil)
        #expect(cached?.title == "Mock APOD")
    }
    
    @Test("Throws error when fetch failed", .tags(.apodRepository))
    func throwErrorIfFetchAPODFailed() async throws {
        // Given
        let sut = self.makeSUT()
        sut.apodService.shouldFailFetchAPOD = true
        
        // When/Then
        await #expect(throws: URLError(.badServerResponse)) {
            _ = try await sut.repo.fetchAPOD(for: Date())
        }
    }

    @Test("Loads cached APOD successfully", .tags(.apodRepository))
    func fetchCachedAPODSuccess() async throws {
        // Given
        let sut = self.makeSUT()
        
        let model = APODModel.stub(title: "Cached APOD")
        
        await sut.cache.save(model, for: "last_apod")
        
        // When
        let result = try await sut.repo.fetchCachedAPOD(for: "last_apod")
        
        // Then
        #expect(result != nil)
        #expect(result?.title == "Cached APOD")
    }
    
    @Test("Returns nil if no cached APOD found", .tags(.apodRepository))
    func returnNilIfNoCachedAPODFound() async throws {
        // Given
        let sut = self.makeSUT()
        
        // When
        let result = try await sut.repo.fetchCachedAPOD(for: "last_apod")
        
        // Then
        #expect(result == nil)
    }
    
    @Test("Fetches image and caches it", .tags(.apodRepository))
    func fetchImageAndCache() async throws {
        // Given
        let sut = self.makeSUT()
        let url = URL(string: "https://test.com/test.jpg")!
        
        // When
        let data = try await sut.repo.fetchImage(from: url)
        
        // Then
        #expect(data == Data([0x1, 0x2]))
        
        let cachedData = await sut.cache.load(Data.self, for: url.absoluteString)
        #expect(cachedData != nil)
        #expect(cachedData == data)
    }
    
    @Test("Returns cached image when fetch fails", .tags(.apodRepository))
    func fetchImageFallbackToCache() async throws {
        // Given
        let sut = self.makeSUT()
        let url = URL(string: "https://test.com/test.jpg")!
        sut.imageService.shouldFailFetchImage = true
        
        let cachedData = Data([0x1, 0x2])
        await sut.cache.save(cachedData, for: url.absoluteString)
        
        // When
        let data = try await sut.repo.fetchImage(from: url)
        
        // Then
        #expect(data == cachedData)
    }
    
    @Test("Throws when both network and cache image fetch fail", .tags(.apodRepository))
    func throwErrorIfFetchImageTotallyFailed() async throws {
        // Given
        let sut = self.makeSUT()
        let url = URL(string: "https://test.com/test.jpg")!
        sut.imageService.shouldFailFetchImage = true
        
        // When/Then
        await #expect(throws: URLError(.cannotLoadFromNetwork)) {
            _ = try await sut.repo.fetchImage(from: url)
        }
    }
}

// MARK: - SUT

extension APODRepositoryTests {
    private typealias SUT = (
        apodService: MockAPODService,
        imageService: MockImageFetchService,
        cache: MockCache,
        repo: APODRepository)
    
    private func makeSUT() -> SUT {
        let apodService = MockAPODService()
        let imageService = MockImageFetchService()
        let cache = MockCache()
        
        let repository = APODRepository(
            apodService: apodService,
            imageService: imageService,
            cache: cache)
        return (apodService, imageService, cache, repository)
    }
}
