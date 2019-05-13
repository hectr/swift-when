import XCTest
import when

final class ENCasualTimeTests: XCTestCase {
    let sut = Parser(rules: [EN.buildCasualTime()])

    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.CasualTime",
                      base: january6th2016,
                      Fixture(text: "The Deadline was this morning ", index: 17, phrase: "this morning", diffInterval: 8 * 3600),
                      Fixture(text: "The Deadline was this noon ", index: 17, phrase: "this noon", diffInterval: 12 * 3600),
                      Fixture(text: "The Deadline was this afternoon", index: 17, phrase: "this afternoon", diffInterval: 15 * 3600),
                      Fixture(text: "The Deadline was this evening", index: 17, phrase: "this evening", diffInterval: 18 * 3600))
    }

    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
