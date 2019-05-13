import XCTest
import when

final class CommonSlashDMYTests: XCTestCase {
    let sut = Parser(rules: [Common.buildSlashDMY()])
    
    func testDoesNotThrowParsingDate() {
        XCTAssertNoThrow(try sut.parse(text: "30/03/2019"))
    }
    
    func testParsesDate() {
        let january1st1970 = Date(intervalSince1970: 24*3600, addingTimeZone: Calendar.current.timeZone)
        let expected = buildResult(index: 0, text: "02/01/1970", source: "02/01/1970", date: january1st1970)
        XCTAssertEqual(try? sut.parse(text: "02/01/1970", base: january1st1970), expected)
    }
    
    func testDoesNotThrowParsingDateInSentence() {
        XCTAssertNoThrow(try sut.parse(text: "The Deadline is 22/04/2019"))
    }
    
    func testParsesDateInSentence() {
        let january2nd2001 = Date(intervalSinceReferenceDate: 48*3600, addingTimeZone: Calendar.current.timeZone)
        let expected = buildResult(index: 16, text: "03/01/2001", source: "The Deadline is 03/01/2001", date: january2nd2001)
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 03/01/2001", base: january1st1970), expected)
    }
    
    func testResultsAreConsistent() {
        let july15th2020 = Date(intervalSince1970: 1594771200, addingTimeZone: Calendar.current.timeZone)
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 10/10/2016", base: july15th2016).date,
                       try? sut.parse(text: "10/10/2016", base: july15th2020).date)
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 1/2/2016", base: july15th2016).date,
                       try? sut.parse(text: "1/2/2016", base: july15th2020).date)
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 29/2/2016", base: july15th2016).date,
                       try? sut.parse(text: "29/2/2016", base: july15th2020).date)
        // next year
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 28/2", base: july15th2016).date,
                       try? sut.parse(text: "28/2/2017", base: july15th2020).date)
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 28/02/2017", base: july15th2020).date,
                       try? sut.parse(text: "28/02", base: july15th2016).date)
        // right after w/o a year
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 28/07", base: july15th2016).date,
                       try? sut.parse(text: "28/07/2016", base: july15th2020).date)
        // before w/o a year
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 30/06", base: july15th2016).date,
                       try? sut.parse(text: "30/06/2017", base: july15th2020).date)
        // prev day will be added to the future
        XCTAssertEqual(try? sut.parse(text: "The Deadline is 14/07", base: july15th2016).date,
                       try? sut.parse(text: "14/07/2017", base: july15th2016).date)
    }
    
    func testComplexCases() {
        // same year
        applyFixtures(parser: sut,
                      name: "Common.SlashDMY",
                      base: july15th2016,
                      Fixture(text: "The Deadline is 10/10/2016", index: 16, phrase: "10/10/2016", diff: (284 - july15th2016Offset)),
                      Fixture(text: "The Deadline is 1/2/2016", index: 16, phrase: "1/2/2016", diff: (32 - july15th2016Offset)),
                      Fixture(text: "The Deadline is 29/2/2016", index: 16, phrase: "29/2/2016", diff: (60 - july15th2016Offset)))
        // next year
        applyFixtures(parser: sut,
                      name: "Common.SlashDMY",
                      base: july15th2016,
                      Fixture(text: "The Deadline is 28/2", index: 16, phrase: "28/2", diff: (59 + 366 - july15th2016Offset)),
                      Fixture(text: "The Deadline is 28/02/2017", index: 16, phrase: "28/02/2017", diff: (59 + 366 - july15th2016Offset)))
        // right after w/o a year
        applyFixtures(parser: sut,
                      name: "Common.SlashDMY",
                      base: july15th2016,
                      Fixture(text: "The Deadline is 28/07", index: 16, phrase: "28/07", diff: (210 - july15th2016Offset)))
        // before w/o a year
        applyFixtures(parser: sut,
                      name: "Common.SlashDMY",
                      base: july15th2016,
                      Fixture(text: "The Deadline is 30/06", index: 16, phrase: "30/06", diff: (181 + 366 - july15th2016Offset)))
        // prev day will be added to the future
        applyFixtures(parser: sut,
                      name: "Common.SlashDMY",
                      base: july15th2016,
                      Fixture(text: "The Deadline is 14/07", index: 16, phrase: "14/07", diff: (195 + 366 - july15th2016Offset)))
    }
    
    static var allTests = [
        ("testDoesNotThrowParsingDate", testDoesNotThrowParsingDate),
        ("testParsesDate", testParsesDate),
        ("testDoesNotThrowParsingDateInSentence", testDoesNotThrowParsingDateInSentence),
        ("testParsesDateInSentence", testParsesDateInSentence),
        ("testResultsAreConsistent", testResultsAreConsistent),
        ("testComplexCases", testComplexCases),
    ]
}
