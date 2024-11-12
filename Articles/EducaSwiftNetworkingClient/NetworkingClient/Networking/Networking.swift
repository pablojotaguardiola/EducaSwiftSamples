//
//  Networking.swift
//  NetworkingClient
//
//  Created by Luis Cárdenas on 12/11/24.
//

import Foundation

protocol Networking {
    func get<T: Decodable>(url urlString: String,
                           headers: [String: String]?) async throws -> T
    func post<T: Decodable>(url urlString: String,
                            parameters: [String: String]?,
                            headers: [String: String]?) async throws -> T
}
