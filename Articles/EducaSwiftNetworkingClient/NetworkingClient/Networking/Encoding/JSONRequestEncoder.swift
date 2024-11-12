//
//  JSONRequestEncoder.swift
//  NetworkingClient
//
//  Created by Luis Cárdenas on 12/11/24.
//

import Foundation

struct JSONRequestEncoder: RequestEncoder {
    func encode<T: Encodable>(_ parameters: T) throws -> Data {
        try JSONEncoder().encode(parameters)
    }
}
