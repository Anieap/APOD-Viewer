//
//  SettingsView.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import SwiftUI

// MARK: - SettingsView

struct SettingsView: View {
    let viewModel: SettingsViewModel
    @State private var showClearCacheAlert = false
    @State private var isClearing = false
    @State private var showSuccessToast = false

    var body: some View {
        NavigationStack {
            Form {
                self.aboutUsSection
                self.cacheSection
                self.appVersionFooter
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog(
                "Are you sure you want to clear all cached data?",
                isPresented: $showClearCacheAlert,
                titleVisibility: .visible
            ) {
                self.clearCacheButton
            }
            .alert("Cache Cleared", isPresented: $showSuccessToast) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    private var aboutUsSection: some View {
        Section {
            NavigationLink(destination: AboutUsView()) {
                Label("About Us", systemImage: "info.circle")
            }
        }
    }
    
    private var cacheSection: some View {
        Section {
            Button(role: .destructive) {
                showClearCacheAlert = true
            } label: {
                if isClearing {
                    HStack {
                        ProgressView()
                        Text("Clearing Cache…")
                    }
                } else {
                    Label("Clear Cache", systemImage: "trash")
                }
            }
            .disabled(isClearing)
        } footer: {
            Text("Remove all cached data to free up space.")
        }
    }
    
    private var appVersionFooter: some View {
        Section {
            HStack {
                Spacer()
                Text("App Version: \(viewModel.getAppVersion())")
                    .foregroundColor(AppColors.gray)
                    .font(AppFonts.footnote)
                Spacer()
            }
        }
    }
    
    private var clearCacheButton: some View {
        Button("Clear Cache", role: .destructive) {
            Task {
                isClearing = true
                await viewModel.clearCache()
                isClearing = false
                showSuccessToast = true
            }
        }
    }
}
