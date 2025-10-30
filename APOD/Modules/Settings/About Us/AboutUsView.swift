//
//  AboutUsView.swift
//  APOD
//
//  Created by Anie Parameswaran on 28/10/2025.
//

import SwiftUI

// MARK: - AboutUsView

struct AboutUsView: View {
    private var viewModel = AboutUsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text(self.viewModel.description())
                .font(.body)
                .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
    }
}
