import XCTest
@testable import EducaSwiftExerciseSearch

final class SearchViewModelTests: XCTestCase {

    func testFilterSearch() async {
        let sut = SearchViewModel()

        await sut.filterSearch(text: "0")

        XCTAssertEqual(sut.filteredItems.count, 10)
        
        await sut.filterSearch(text: "1")

        XCTAssertEqual(sut.filteredItems.count, 19)
    }
}
