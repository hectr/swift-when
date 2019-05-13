import XCTest
import when

final class CommonSimpleFourDigitsYearTests: XCTestCase {
    let sut = Parser(rules: [Common.buildSimpleFourDigitsYear()])

    func testComplexCases() {
        // same year
        applyFixtures(parser: sut,
                      name: "Common.SimpleFourDigitsYear",
                      base: july15th2016,
                      Fixture(text: "1999", index: 0, phrase: "1999", diff: (-6013 - july15th2016Offset)),
                      Fixture(text: "The year was 2002", index: 13, phrase: "2002", diff: (-4917 - july15th2016Offset)),
                      Fixture(text: "in 1725 ", index: 3, phrase: "1725", diff: (-106089 - july15th2016Offset)))
    }
    
    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
