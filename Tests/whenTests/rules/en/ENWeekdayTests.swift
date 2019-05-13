import XCTest
import when

final class ENWeekdayTests: XCTestCase {
    let sut = Parser(rules: [EN.buildWeekday()])

    func testComplexCases() {
        // same year
        applyFixtures(parser: sut,
                      name: "EN.Weekday",
                      base: january6th2016,
                      Fixture(text: "do it for the past Monday", index: 14, phrase: "past Monday", diffInterval: -2 * 24 * 3600),
                      Fixture(text: "past saturday", index: 0, phrase: "past saturday", diffInterval: -4 * 24 * 3600),
                      Fixture(text: "past friday", index: 0, phrase: "past friday", diffInterval: -5 * 24 * 3600),
                      Fixture(text: "past wednesday", index: 0, phrase: "past wednesday", diffInterval: -7 * 24 * 3600),
                      Fixture(text: "past tuesday", index: 0, phrase: "past tuesday", diffInterval: -1 * 24 * 3600))
        // next
        applyFixtures(parser: sut,
                      name: "EN.Weekday",
                      base: january6th2016,
                      Fixture(text: "next tuesday", index: 0, phrase: "next tuesday", diffInterval: 6 * 24 * 3600),
                      Fixture(text: "drop me a line at next wednesday", index: 18, phrase: "next wednesday", diffInterval: 7 * 24 * 3600),
                      Fixture(text: "next saturday", index: 0, phrase: "next saturday", diffInterval: 3 * 24 * 3600))
        // this
        applyFixtures(parser: sut,
                      name: "EN.Weekday",
                      base: january6th2016,
                      Fixture(text: "this tuesday", index: 0, phrase: "this tuesday", diffInterval: -1 * 24 * 3600),
                      Fixture(text: "drop me a line at this wednesday", index: 18, phrase: "this wednesday", diffInterval: 0),
                      Fixture(text: "this saturday", index: 0, phrase: "this saturday", diffInterval: 3 * 24 * 3600))
    }

    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
