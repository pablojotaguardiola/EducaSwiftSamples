//
//  JSONResponseDecoder.swift
//  NetworkingClient
//
//  Created by Luis Cárdenas on 12/11/24.
//

import Foundation

struct JSONResponseDecoder: ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
