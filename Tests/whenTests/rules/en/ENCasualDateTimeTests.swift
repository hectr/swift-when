import XCTest
import when

final class ENCasualDateTimeTests: XCTestCase {
    let sut = Parser(rules: [EN.buildCasualDate(), EN.buildCasualTime()])
    
    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.CasualDate|EN.CasualTime",
                      base: january6th2016,
                      Fixture(text: "The Deadline is tomorrow this afternoon", index: 16, phrase: "tomorrow this afternoon", diffInterval: (15 + 24) * 3600))
    }
    
    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
