import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var persons: FetchedResults<Person>

    @State var inputText: String = ""

    var body: some View {
        VStack {
            List(persons) { person in
                Text(person.name ?? "No name")
            }

            inputBar
        }
    }

    var inputBar: some View {
        HStack {
            TextField("", text: $inputText)
                .textFieldStyle(.roundedBorder)

            Button {
                addPerson(name: inputText)
                inputText = ""
            } label: {
                Text("ADD")
            }
        }
        .padding()
    }

    func addPerson(name: String) {
        var person = Person(context: moc)
        person.id = UUID()
        person.name = name

        try? moc.save()
    }
}

#Preview {
    ContentView()
}
