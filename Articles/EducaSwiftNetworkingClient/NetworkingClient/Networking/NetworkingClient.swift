//
//  NetworkingClient.swift
//  NetworkingClient
//
//  Created by Luis Cárdenas on 12/11/24.
//

import Foundation

struct NetworkingClient: Networking {
    private let session: URLSession
    private let encoder: RequestEncoder
    private let decoder: ResponseDecoder

    init(
        session: URLSession = URLSession.shared,
        encoder: RequestEncoder = JSONRequestEncoder(),
        decoder: ResponseDecoder = JSONResponseDecoder()
    ) {
        self.session = session
        self.encoder = encoder
        self.decoder = decoder
    }

    func get<T: Decodable>(
        url urlString: String,
        headers: [String: String]? = nil
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkingError.badUrl
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = "GET"

        let (data, _) = try await session.data(for: request)
        return try decoder.decode(data) as T
    }

    func post<T: Decodable>(
        url urlString: String,
        parameters: [String: String]? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkingError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = try encoder.encode(parameters)
        request.httpBody = body

        headers?.forEach { request.allHTTPHeaderFields?[$0.key] = $0.value }

        if request.allHTTPHeaderFields?["Content-Type"] == nil {
            request.allHTTPHeaderFields?.updateValue("Content-Type", forKey: "application/json")
        }

        let (data, _) = try await session.data(for: request)
        return try decoder.decode(data) as T
    }
}
