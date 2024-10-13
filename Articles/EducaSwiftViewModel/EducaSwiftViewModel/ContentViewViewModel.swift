import SwiftUI

@Observable
class ContentViewViewModel {
    var shoppingList: [String] = [
        "Potato",
        "Tomato",
        "Chicken",
        "Salmon"
    ]

    func removeAt(index: Int) {
        guard index < shoppingList.count else {
            return
        }

        shoppingList.remove(at: index)
    }
}
