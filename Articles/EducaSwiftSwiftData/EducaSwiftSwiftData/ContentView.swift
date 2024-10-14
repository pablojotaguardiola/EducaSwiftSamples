import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @Query var tasks: [TodoTask] = []

    @State var text: String = ""

    var body: some View {
        List(tasks) { task in
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(task.title)
            }
            .onTapGesture {
                task.isCompleted.toggle()
            }
        }
        
        HStack {
            TextField("Add a task...", text: $text)
                .textFieldStyle(.roundedBorder)

            Button(action: {
                guard !text.isEmpty else {
                    return
                }
                modelContext.insert(TodoTask(title: text))
                text = ""
            }, label: {
                Text("Add")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
