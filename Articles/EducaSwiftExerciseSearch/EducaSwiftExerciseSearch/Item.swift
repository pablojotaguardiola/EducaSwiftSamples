struct Item: Identifiable {
    let id: Int
    let name: String
}

extension Item {
    static var mock: [Item] {
        (0..<100).map { Item(id: $0, name: "Item \($0)") }
    }
}
