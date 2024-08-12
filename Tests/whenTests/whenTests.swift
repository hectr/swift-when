import XCTest
import when

final class whenTests: XCTestCase {
    func testDefaultDistance() {
        let parser = Parser(rules: EN.all + [Common.buildSimpleFourDigitsYear()])
        let text = "February 23, 2019 | 1:46pm"
        // With default distance (5):
        // February 23, 1970 | 1:46pm
        //                 └─┬─┘
        //           distance: 3 ("February 23, 2019" will be clustered with "1:46pm")
        let result = try? parser.parse(text: text, base: january1st1970)
        XCTAssertEqual(result?.range.location, 0)
        XCTAssertEqual(result?.text, "February 23, 2019 | 1:46pm")
        print(result!.date)
    }

    func testCustomDistance() {
        let options = Options(maxDistance: 2)
        let parser = Parser(options: options, rules: EN.all + [Common.buildSimpleFourDigitsYear()])
        let text = "February 23, 2019 | 1:46pm"
        // With custom distance (2):
        // February 23, 1970 | 1:46pm
        //                 └─┬─┘
        //           distance: 3 (1:46pm will be ignored)
        let result = try? parser.parse(text: text, base: january1st1970)
        XCTAssertEqual(result?.range.location, 0)
        XCTAssertEqual(result?.text, "February 23, 2019")
        print(result!.date)
    }
}
