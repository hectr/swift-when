import XCTest
import when

final class ENTests: XCTestCase {
    let sut = Parser(rules: EN.all)
    
    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.all",
                      base: january6th2016,
                      Fixture(text: "tonight at 11:10 pm", index: 0, phrase: "tonight at 11:10 pm", diffInterval: (23 * 3600) + (10 * 60)),
                      Fixture(text: "at Friday afternoon", index: 0, phrase: "at Friday afternoon", diffInterval: ((2 * 24) + 15) * 3600),
                      Fixture(text: "in next tuesday at 14:00", index: 3, phrase: "next tuesday at 14:00", diffInterval: ((6 * 24) + 14) * 3600),
                      Fixture(text: "in next tuesday at 2p", index: 3, phrase: "next tuesday at 2p", diffInterval: ((6 * 24) + 14) * 3600),
                      Fixture(text: "in next wednesday at 2:25 p.m.", index: 3, phrase: "next wednesday at 2:25 p.m.", diffInterval: (((7 * 24) + 14) * 3600) + (25 * 60)),
                      Fixture(text: "at 11 am past tuesday", index: 3, phrase: "11 am past tuesday", diffInterval: -13 * 3600))
    }
    
    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
