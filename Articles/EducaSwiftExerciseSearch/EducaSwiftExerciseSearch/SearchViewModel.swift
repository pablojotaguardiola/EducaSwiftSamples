import Combine
import SwiftUI

@Observable
class SearchViewModel {

    var allItems: [Item] = Item.mock

    var filteredItems: [Item] = Item.mock

    var searchText: String = "" {
        didSet {
            Task {
                await filterSearch(text: searchText)
            }
        }
    }

    func filterSearch(text: String) async {
        let newFilteredItems = allItems
            .filter { item in
                if text.isEmpty {
                    return true
                }

                return item.name.lowercased().contains(text.lowercased())
            }

        filteredItems = newFilteredItems
    }
}
