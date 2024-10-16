import CoreData
import SwiftUI

@Observable
class ViewModel {

    let moc = CoreData.shared.container.viewContext

    var persons: [Person] = []
    var inputText: String = ""

    func onAppear() {
        fetchData()
    }

    private func fetchData() {
        // Create NSFetchRequest instance
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")

        // Add sort descriptors
        let sortDescriptor = NSSortDescriptor(keyPath: \Person.name, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        // Add predicate (uncomment to apply a filter)
        //let predicate = NSPredicate(format: "name == %@", "Pablo")
        //fetchRequest.predicate = predicate

        // Fetch data
        do {
            persons = try moc.fetch(fetchRequest)
        } catch let error {
            print("Error fetching items: \(error.localizedDescription)")
        }
    }

    func addButtonTapped() {
        guard !inputText.isEmpty else {
            return
        }

        addPerson(name: inputText)

        inputText = ""
    }

    private func addPerson(name: String) {
        var person = Person(context: moc)
        person.id = UUID()
        person.name = name

        try? moc.save()

        fetchData()
    }
}
