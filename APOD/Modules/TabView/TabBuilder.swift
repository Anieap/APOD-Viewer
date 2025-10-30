//
//  TabBuilder.swift
//  APOD
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import SwiftUI

// MARK: - TabBuilder

protocol TabBuilder {
    var id: String { get }
    var label: Label<Text, Image> { get }
    var content: AnyView { get }
}

// MARK: - TodayTab

struct TodayTab: TabBuilder {
    let id = "Today_Tab"
    var label: Label<Text, Image> {
        Label("Today", systemImage: "doc.text.image")
    }
    var content: AnyView {
        AnyView(APODView(viewModel: APODViewModel()))
    }
}

// MARK: - SettingsTab

struct SettingsTab: TabBuilder {
    let id = "Settings_Tab"
    var label: Label<Text, Image> {
        Label("Settings", systemImage: "gearshape")
    }
    var content: AnyView {
        AnyView(SettingsView(viewModel: SettingsViewModel()))
    }
}
