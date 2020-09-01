import XCTest
@testable import Kana

final class KanaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Kana().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
