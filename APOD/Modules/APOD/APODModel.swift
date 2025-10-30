//
//  APODModel.swift
//  APOD
//
//  Created by Anie Parameswaran on 26/10/2025.
//

import Foundation

// MARK: - APODModel

struct APODModel: Codable {
    let date: String
    let title: String
    let explanation: String
    let mediaType: MediaType
    let url: String?
    let hdUrl: String?
    let serviceVersion: String?
    let thumbnailURL: String?
    
    enum MediaType: String, Codable {
        case image
        case video
    }
    
    enum CodingKeys: String, CodingKey {
        case date, title, explanation
        case mediaType = "media_type"
        case url
        case hdUrl = "hdurl"
        case serviceVersion = "service_version"
        case thumbnailURL = "thumbnail_url"
    }
}
