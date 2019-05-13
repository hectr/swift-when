import XCTest
import when

final class ENHourTests: XCTestCase {
    let sut = Parser(rules: [EN.buildHour()])
    
    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.Hour",
                      base: january6th2016,
                      Fixture(text: "5pm", index: 0, phrase: "5pm", diffInterval: 17 * 3600),
                      Fixture(text: "at 5 pm", index: 3, phrase: "5 pm", diffInterval: 17 * 3600),
                      Fixture(text: "at 5 P.", index: 3, phrase: "5 P.", diffInterval: 17 * 3600),
                      Fixture(text: "at 12 P.", index: 3, phrase: "12 P.", diffInterval: 12 * 3600),
                      Fixture(text: "at 1 P.", index: 3, phrase: "1 P.", diffInterval: 13 * 3600),
                      Fixture(text: "at 5 am", index: 3, phrase: "5 am", diffInterval: 5 * 3600),
                      Fixture(text: "at 5A", index: 3, phrase: "5A", diffInterval: 5 * 3600),
                      Fixture(text: "at 5A.", index: 3, phrase: "5A.", diffInterval: 5 * 3600),
                      Fixture(text: "5A.", index: 0, phrase: "5A.", diffInterval: 5 * 3600),
                      Fixture(text: "11 P.M.", index: 0, phrase: "11 P.M.", diffInterval: 23 * 3600))
    }
    
    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
