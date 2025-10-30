//
//  NetworkSession.swift
//  APOD
//
//  Created by Anie Parameswaran on 30/10/2025.
//

import Foundation

// MARK: - NetworkSession

protocol NetworkSession {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
