import XCTest
import when

final class ENDeadlineTests: XCTestCase {
    let sut = Parser(rules: [EN.buildDeadline()])

    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.Deadline",
                      base: january6th2016,
                      Fixture(text: "within half an hour", index: 0, phrase: "within half an hour", diffInterval: 3600 / 2),
                      Fixture(text: "within 1 hour", index: 0, phrase: "within 1 hour", diffInterval: 3600),
                      Fixture(text: "in 5 minutes", index: 0, phrase: "in 5 minutes", diffInterval: 60 * 5),
                      Fixture(text: "In 5 minutes I will go home", index: 0, phrase: "In 5 minutes", diffInterval: 60 * 5),
                      Fixture(text: "we have to do something within 10 days.", index: 24, phrase: "within 10 days", diffInterval: 10 * 24 * 3600),
                      Fixture(text: "we have to do something in five days.", index: 24, phrase: "in five days", diffInterval: 5 * 24 * 3600),
                      Fixture(text: "we have to do something in 5 days.", index: 24, phrase: "in 5 days", diffInterval: 5 * 24 * 3600),
                      Fixture(text: "In 5 seconds A car need to move", index: 0, phrase: "In 5 seconds", diffInterval: 5),
                      Fixture(text: "within two weeks", index: 0, phrase: "within two weeks", diffInterval: 14 * 24 * 3600),
                      Fixture(text: "within a month", index: 0, phrase: "within a month", diffInterval: 31 * 24 * 3600),
                      Fixture(text: "within a few months", index: 0, phrase: "within a few months", diff: 91),
                      Fixture(text: "within one year", index: 0, phrase: "within one year", diffInterval: 366 * 24 * 3600),
                      Fixture(text: "in a week", index: 0, phrase: "in a week", diffInterval: 7 * 24 * 3600))
    }

    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
