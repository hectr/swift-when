import XCTest
import when

final class ENCasualDateTests: XCTestCase {
    let sut = Parser(rules: [EN.buildCasualDate()])

    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.CasualDate",
                      base: january6th2016,
                      Fixture(text: "The Deadline is now, ok", index: 16, phrase: "now", diffInterval: 0),
                      Fixture(text: "The Deadline is today", index: 16, phrase: "today", diffInterval: 0),
                      Fixture(text: "The Deadline is tonight", index: 16, phrase: "tonight", diffInterval: 23 * 3600),
                      Fixture(text: "The Deadline is tomorrow evening", index: 16, phrase: "tomorrow", diffInterval: 24 * 3600),
                      Fixture(text: "The Deadline is yesterday evening", index: 16, phrase: "yesterday", diffInterval: -1 * 24 * 3600))
    }

    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
