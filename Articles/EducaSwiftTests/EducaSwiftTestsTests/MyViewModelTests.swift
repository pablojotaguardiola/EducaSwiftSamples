import XCTest
@testable import EducaSwiftTests

class MyViewModelTests: XCTestCase {

    func testGetSquare() {
        let sut = MyViewModel()

        let expectedResult = sut.getSquare(number: 3)

        XCTAssertEqual(expectedResult, 9)
    }
}
