struct Product: Decodable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var price: String
    var thumbnail: String
}
