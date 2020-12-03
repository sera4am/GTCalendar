import XCTest
@testable import GTCalendar

final class GTCalendarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GTCalendar().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
