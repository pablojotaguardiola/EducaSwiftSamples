import SwiftUI

struct ContentView: View {

    @State var viewModel = ViewModel()

    var body: some View {
        VStack {
            List(viewModel.persons) { person in
                Text(person.name ?? "No name")
            }

            inputBar
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }

    var inputBar: some View {
        HStack {
            TextField("", text: $viewModel.inputText)
                .textFieldStyle(.roundedBorder)

            Button {
                viewModel.addButtonTapped()
            } label: {
                Text("ADD")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
