import CoreData
import SwiftUI

@Observable
class CoreData {
    let container = NSPersistentContainer(name: "Model")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

}
