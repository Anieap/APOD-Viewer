//
//  APODViewModel.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

// MARK: - APODViewModel

final class APODViewModel: ObservableObject {
    
    @Published private(set) var model: APODModel?
    @Published private(set) var isLoading = false
    @Published private(set) var error: String = ""
    @Published private(set) var imageData: Data?
    @Published var selectedDate: Date = Date()
    
    private let repository: APODRepositoryProtocol
    
    init(repo: APODRepositoryProtocol = APODRepository()) {
        self.repository = repo
        
        Task {
            await self.loadAPOD()
        }
    }
    
    @MainActor
    func loadAPOD() async {
        self.isLoading = true
        do {
            let result = try await self.repository.fetchAPOD(for: self.selectedDate)
            await self.handleResult(result)
        } catch {
            await self.loadCachedAPOD()
        }
        self.isLoading = false
    }
    
    private func loadCachedAPOD() async {
        do {
            guard let result = try await self.repository.fetchCachedAPOD(for: "last_apod") else {
                await self.setError()
                return
            }
            await self.handleResult(result)
        } catch {
            await self.setError()
        }
    }
    
    @MainActor
    private func setError() async {
        self.error = "Error loading APOD. Please try again later."
    }
    
    @MainActor
    private func handleResult(_ model: APODModel) async {
        self.model = model
        self.error = ""
        await self.loadImage(for: model)
    }
    
    private func loadImage(for model: APODModel) async {
        guard let urlString = model.mediaType == .image
                ? model.hdUrl ?? model.url
                : model.thumbnailURL else { return }
        guard let url = URL(string: urlString) else { return }
        
        do {
            let imageData = try await repository.fetchImage(from: url)
            await MainActor.run {
                self.imageData = imageData
            }
        } catch {
            print("failed to load Image")
        }
    }
}
