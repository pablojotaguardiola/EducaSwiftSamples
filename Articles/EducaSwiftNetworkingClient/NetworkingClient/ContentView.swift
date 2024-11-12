//
//  ContentView.swift
//  NetworkingClient
//
//  Created by Luis Cárdenas on 12/11/24.
//

import SwiftUI

struct Product: Decodable {
    let id: Int
    let title: String
}

struct ContentView: View {
    @State var products: [Product] = []

    private let client = NetworkingClient()

    var body: some View {
        NavigationStack {
            List(products, id: \.id) { product in
                Text(product.title)
            }
            .task {
                do {
                    products = try await client.get(url: "https://educaswift.com/public/products.json")
                } catch {
                    print("error: \(error)")
                }
            }
            .navigationTitle("Products")
        }
    }
}

#Preview {
    ContentView()
}
