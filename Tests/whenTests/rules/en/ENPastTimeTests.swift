import XCTest
import when

final class ENPastTimeTests: XCTestCase {
    let sut = Parser(rules: [EN.buildPastTime()])

    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.PastTime",
                      base: january6th2016,
                      Fixture(text: "half an hour ago", index: 0, phrase: "half an hour ago", diffInterval: -3600 / 2),
                      Fixture(text: "1 hour ago", index: 0, phrase: "1 hour ago", diffInterval: -3600),
                      Fixture(text: "5 minutes ago", index: 0, phrase: "5 minutes ago", diffInterval: -60 * 5),
                      Fixture(text: "5 minutes ago I went to the zoo", index: 0, phrase: "5 minutes ago", diffInterval: -60 * 5),
                      Fixture(text: "we did something 10 days ago.", index: 17, phrase: "10 days ago", diffInterval: -10 * 24 * 3600),
                      Fixture(text: "we did something five days ago.", index: 17, phrase: "five days ago", diffInterval: -5 * 24 * 3600),
                      Fixture(text: "we did something 5 days ago.", index: 17, phrase: "5 days ago", diffInterval: -5 * 24 * 3600),
                      Fixture(text: "5 seconds ago a car was moved", index: 0, phrase: "5 seconds ago", diffInterval: -5),
                      Fixture(text: "two weeks ago", index: 0, phrase: "two weeks ago", diffInterval: -14 * 24 * 3600),
                      Fixture(text: "a month ago", index: 0, phrase: "a month ago", diffInterval: -31 * 24 * 3600),
                      Fixture(text: "a few months ago", index: 0, phrase: "a few months ago", diff: -92),
                      Fixture(text: "one year ago", index: 0, phrase: "one year ago", diffInterval: -365 * 24 * 3600),
                      Fixture(text: "a week ago", index: 0, phrase: "a week ago", diffInterval: -7 * 24 * 3600))
    }

    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
