//
//  AboutUsViewModel.swift
//  APOD
//
//  Created by Anie Parameswaran on 28/10/2025.
//

import Foundation

// MARK: - AboutUsViewModel

final class AboutUsViewModel {
    func description() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
        let currentYear = Calendar.current.component(.year, from: Date())
        let description = """
            This app provides you with daily insights and media content directly from NASA's Astronomy Picture of the Day (APOD) service. Our mission is to make science accessible and inspiring for everyone.

            Version: \(version)
            Build: \(build)

            © \(currentYear) Anie's App. All rights reserved.
            """
        return description
    }
}
