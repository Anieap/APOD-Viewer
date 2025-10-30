//
//  TabProvider.swift
//  APOD
//
//  Created by Anie Parameswaran on 29/10/2025.
//

import Foundation

// MARK: - TabProvider

final class TabProvider {
    static var availableTabs: [any TabBuilder] = [
        TodayTab(),
        SettingsTab()
    ]
}
