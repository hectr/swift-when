import XCTest
import when

final class ENHourMinuteTests: XCTestCase {
    func testComplexCases() {
        let sut = Parser(rules: [EN.buildHourMinute()])
        applyFixtures(parser: sut, name: "EN.HourMinute")
    }

    func testSkippingHour() {
        let sut = Parser(rules: [EN.buildHourMinute(), EN.buildHour(strategy: .skip)])
        applyFixtures(parser: sut, name: "EN.HourMinute|EN.Hour")
    }

    func testOverridingHour() {
        let sut = Parser(rules: [EN.buildHour(), EN.buildHourMinute()])
        applyFixtures(parser: sut, name: "EN.Hour|EN.HourMinute")
    }

    private func applyFixtures(parser: Parser, name: String) {
        applyFixtures(parser: parser,
                      name: name,
                      base: january6th2016,
                      Fixture(text: "5:30pm", index: 0, phrase: "5:30pm", diffInterval: 17 * 3600 + 30 * 60),
                      Fixture(text: "at 5:30 pm", index: 3, phrase: "5:30 pm", diffInterval: 17 * 3600 + 30 * 60),
                      Fixture(text: "at 5:59 pm", index: 3, phrase: "5:59 pm", diffInterval: 17 * 3600 + 59 * 60),
                      Fixture(text: "at 5-59 pm", index: 3, phrase: "5-59 pm", diffInterval: 17 * 3600 + 59 * 60),
                      Fixture(text: "at 17-59 pam", index: 3, phrase: "17-59", diffInterval: 17 * 3600 + 59 * 60),
                      Fixture(text: "up to 11:10 pm", index: 6, phrase: "11:10 pm", diffInterval: 23 * 3600 + 10 * 60))

        applyFixturesNil(parser: parser,
                         name: name,
                         base: january6th2016,
                         Fixture(text: "28:30pm", index: 0, phrase: "", diffInterval: 0),
                         Fixture(text: "12:61pm", index: 3, phrase: "", diffInterval: 0),
                         Fixture(text: "24:10", index: 3, phrase: "", diffInterval: 0))
    }
    
    static var allTests = [
        ("testComplexCases", testComplexCases),
        ("testSkippingHour", testSkippingHour),
        ("testOverridingHour", testOverridingHour),
    ]
}
