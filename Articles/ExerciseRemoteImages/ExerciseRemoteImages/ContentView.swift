import Alamofire
import SwiftUI

struct ContentView: View {

    @State var products: [Product] = []

    var body: some View {
        VStack {
            Button {
                loadProducts()
            } label: {
                Text("Download")
            }

            List {
                ForEach(products) { product in
                    HStack(alignment: .top) {
                        productImage(url: product.thumbnail)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text(product.description)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Text(product.price)
                                .font(.title3)
                        }
                    }
                }
            }
        }
    }

    func productImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    func loadProducts() {
        AF.request("https://educaswift.com/public/products.json")
            .response { response in
                if let data = response.data,
                   let products = try? JSONDecoder().decode([Product].self, from: data) {
                    self.products = products
                }
            }
    }
}

#Preview {
    ContentView()
}
