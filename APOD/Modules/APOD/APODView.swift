//
//  APODView.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import SwiftUI
import AVKit

// MARK: - APODView

struct APODView: View {
    @ObservedObject var viewModel: APODViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    self.datePickerView
                    if viewModel.error.isEmpty {
                        self.title
                        self.mediaView
                        self.explanation
                    } else {
                        self.errorView
                    }
                }
                .padding()
            }
            .navigationTitle(Text("APOD"))
        }
    }
    
    private var datePickerView: some View {
        DatePickerView(
            selectedDate: $viewModel.selectedDate,
            title: "Date",
            action: {
                Task { await viewModel.loadAPOD() }
            }
        )
    }
    
    private var title: some View {
        Text(viewModel.model?.title ?? "")
            .font(.title2.bold())
    }
    
    private var explanation: some View {
        Text(viewModel.model?.explanation ?? "")
            .font(.body)
            .multilineTextAlignment(.center)
    }
    
    private var placeholder: some View {
        Image(systemName: "photo")
            .resizable()
            .foregroundStyle(.gray)
            .aspectRatio(contentMode: .fill)
    }
    
    private var errorView: some View {
        VStack{
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.red)
            
            Text(viewModel.error)
                .foregroundColor(.red)
                .font(.headline)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private var image: some View {
        if let data = self.viewModel.imageData,
           let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else if viewModel.isLoading {
            ProgressView()
        } else {
            self.placeholder
        }
    }
    
    @ViewBuilder
    private var video: some View {
        if let url = URL(string: self.viewModel.model?.hdUrl ?? "") {
            WebVideoView(url: url)
                .frame(height: 300)
                .border(.gray)
                .padding(.bottom, 8)
        } else {
            self.placeholder
        }
    }
    
    @ViewBuilder
    private var mediaView: some View {
        if self.viewModel.model?.mediaType == .image {
            self.image
        } else if self.viewModel.model?.mediaType == .video {
            self.video
        } else {
            self.placeholder
        }
    }
}
