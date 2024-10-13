import SwiftUI

struct ContentView: View {

    @State var viewModel = ContentViewViewModel()

    var body: some View {
        List(0..<viewModel.shoppingList.count, id: \.self) { index in
            Button {
                viewModel.removeAt(index: index)
            } label: {
                Text(viewModel.shoppingList[index])
            }
        }
    }
}

#Preview {
    ContentView()
}
