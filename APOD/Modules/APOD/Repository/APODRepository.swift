//
//  APODRepository.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

// MARK: - APODRepositoryProtocol

protocol APODRepositoryProtocol {
    func fetchAPOD(for date: Date) async throws -> APODModel
    func fetchCachedAPOD(for key: String) async throws -> APODModel?
    func fetchImage(from url: URL) async throws -> Data
}

// MARK: - APODRepository

final class APODRepository: APODRepositoryProtocol {
    private let apodService: APODServiceProvider
    private let imageService: ImageFetchable
    private let cache: Cacheable
    
    init(apodService: APODServiceProvider = APODService(),
         imageService: ImageFetchable = ImageFetchService(),
         cache: Cacheable = CacheManager()) {
        self.apodService = apodService
        self.imageService = imageService
        self.cache = cache
    }
    
    func fetchAPOD(for date: Date) async throws -> APODModel {
        do {
            /* NOTE TO REVIEWER:
                The APOD API is currently unavailable, so live data cannot be fetched at this time.
                To preview the final output with data, you can either:
                    - Use `MockAPODService`, which loads sample data from a local JSON file, or
                    - Create your own mock data and inject it here.
            */
            let model = try await apodService.fetchAPOD(for: date)
            await self.cache.save(model, for: "last_apod")
            return model
        } catch {
            throw error
        }
    }
    
    func fetchCachedAPOD(for key: String) async throws -> APODModel? {
        guard let cachedModel = await cache.load(
            APODModel.self,
            for: key) else { return nil }
        return cachedModel
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await self.imageService.fetch(url: url)
            await self.cache.save(data, for: url.absoluteString)
            return data
        } catch {
            guard let cachedImage = await cache.load(
                Data.self,
                for: url.absoluteString) else { throw error }
            return cachedImage
        }
    }
}
