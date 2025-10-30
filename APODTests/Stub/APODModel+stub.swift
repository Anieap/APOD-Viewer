//
//  APODModel+stub.swift
//  APODTests
//
//  Created by Anie Parameswaran on 30/10/2025.
//

import Testing
@testable import APOD

extension APODModel {
    static func stub(
        date: String = "2025-10-27",
        title: String = "Mock APOD",
        explanation: String = "Mock explanation",
        mediaType: APODModel.MediaType = .image,
        url: String? = "https://test.com/testImage.jpg",
        hdUrl: String? = nil,
        serviceVersion: String = "",
        thumbnailURL: String? = nil
    ) -> Self {
        APODModel(
            date: "2025-10-27",
            title: title,
            explanation: "Mock explanation",
            mediaType: .image,
            url: "https://test.com/testImage.jpg",
            hdUrl: nil,
            serviceVersion: "",
            thumbnailURL: nil
        )
    }
}

