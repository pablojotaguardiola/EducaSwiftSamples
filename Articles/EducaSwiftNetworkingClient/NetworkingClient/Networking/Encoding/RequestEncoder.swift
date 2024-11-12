//
//  RequestEncoder.swift
//  NetworkingClient
//
//  Created by Luis Cárdenas on 12/11/24.
//

import Foundation

protocol RequestEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
