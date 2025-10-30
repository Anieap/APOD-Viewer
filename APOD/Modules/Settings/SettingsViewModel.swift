//
//  SettingsViewModel.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

// MARK: - SettingsViewModel

class SettingsViewModel {
    private let cache: Cacheable

    init(cache: Cacheable = CacheManager()) {
        self.cache = cache
    }

    func clearCache() async {
        await cache.clear()
    }
    
    func getAppVersion() -> String {
        "v" + "\(Bundle.main.releaseVersion ?? "0.0.0")"
    }
}

extension Bundle {
    var releaseVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
