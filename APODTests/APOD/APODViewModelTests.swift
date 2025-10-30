//
//  APODViewModelTests.swift
//  APODTests
//
//  Created by Anie Parameswaran on 28/10/2025.
//

import Testing
import Foundation
@testable import APOD

// MARK: - APODViewModelTests

@Suite("APODViewModel Tests")
struct APODViewModelTests {

    @Test("Loads APOD successfully", .tags(.apodViewModel))
    func apodLoadsSuccessfully() async throws {
        // Given
        let sut = self.makeSUT()
        
        // When
        await sut.viewModel.loadAPOD()
        
        // Then
        #expect(sut.viewModel.model?.title == "Mock APOD")
        #expect(sut.viewModel.error.isEmpty)
        #expect(sut.viewModel.imageData != nil)
    }
    
    @Test("Falls back to cached APOD when fetch fails", .tags(.apodViewModel))
    func apodLoadsSuccessfullyFromCache() async throws {
        // Given
        let sut = self.makeSUT()
        sut.repo.shouldFailFetch = true
        
        // When
        await sut.viewModel.loadAPOD()
        
        // Then
        #expect(sut.viewModel.model?.title == "Cached APOD")
        #expect(sut.viewModel.error.isEmpty)
    }
    
    @Test("Sets error when both fetch and cache fail", .tags(.apodViewModel))
    func throwErrorIfFetchingFailed() async throws {
        // Given
        let sut = self.makeSUT()
        sut.repo.shouldFailFetch = true
        sut.repo.shouldFailCachedFetch = true
        
        // When
        await sut.viewModel.loadAPOD()
        
        // Then
        #expect(sut.viewModel.model == nil)
        #expect(sut.viewModel.error == "Error loading APOD. Please try again later.")
    }
    
    @Test("Uses selected date when no date is passed", .tags(.apodViewModel))
    func useSelectedDateIfNoDatePassed() async throws {
        // Given
        let sut = self.makeSUT()
        let dateString = "2025-10-28"
        sut.viewModel.selectedDate = dateString.toDate()!
        
        // When
        #expect(sut.viewModel.selectedDate == dateString.toDate())
        await sut.viewModel.loadAPOD()
        
        // Then
        #expect(sut.viewModel.selectedDate == dateString.toDate())
    }
    
    @Test("Loads image data when APOD has a valid image url", .tags(.apodViewModel))
    func loadImageWithValidUrl() async throws {
        // Given
        let sut = self.makeSUT()
        
        // When
        await sut.viewModel.loadAPOD()
        
        // Given
        #expect(sut.repo.fetchImageCalled)
        #expect(sut.viewModel.imageData != nil)
    }
    
    @Test("Loads image data without a valid image url", .tags(.apodViewModel))
    func loadImageWithInvalidUrl() async throws {
        // Given
        let sut = self.makeSUT()
        sut.repo.shouldFailImageFetch = true
        
        // When
        await sut.viewModel.loadAPOD()
        
        // Given
        #expect(sut.repo.fetchImageCalled)
        #expect(sut.viewModel.imageData == nil)
    }
}

// MARK: - SUT

extension APODViewModelTests {
    private typealias SUT = (repo: MockAPODRepository, viewModel: APODViewModel)
    
    private func makeSUT() -> SUT {
        let repository = MockAPODRepository()
        let viewModel = APODViewModel(repo: repository)
        return (repository, viewModel)
    }
}
