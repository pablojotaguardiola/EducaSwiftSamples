import SwiftUI

struct ContentView: View {

    @State var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
                .padding()

            List(viewModel.filteredItems) { item in
                Text(item.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
