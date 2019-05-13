import XCTest
@testable import when

let january1st1970 = Date(intervalSince1970: 24*3600, addingTimeZone: Calendar.current.timeZone)
let january2nd2001 = Date(intervalSinceReferenceDate: 48*3600, addingTimeZone: Calendar.current.timeZone)
let january6th2016 = Date(intervalSince1970: 1452038400, addingTimeZone: Calendar.current.timeZone)
let july15th2016 = Date(intervalSince1970: 1468540800, addingTimeZone: Calendar.current.timeZone)
let july15th2020 = Date(intervalSince1970: 1594771200, addingTimeZone: Calendar.current.timeZone)

// July 15th days offset from the begining of the year
let july15th2016Offset = 197

struct Fixture {
    let text: String
    let index: Int
    let phrase: String
    let diff: Int?
    let diffInterval: TimeInterval
    
    init(text: String, index: Int, phrase: String, diff: Int) {
        self.text = text
        self.index = index
        self.phrase = phrase
        self.diff = diff
        self.diffInterval = TimeInterval(diff * 24 * 3600)
    }
    
    init(text: String, index: Int, phrase: String, diffInterval: TimeInterval) {
        self.text = text
        self.index = index
        self.phrase = phrase
        self.diff = nil
        self.diffInterval = diffInterval
    }
}

extension XCTestCase {
    func buildResult(index: Int, text: String, source: String, date: Date) -> Result {
        return Result(index: index, text: text, source: source, date: date)
    }

    func applyFixtures(parser: Parser, name: String, base: Date, _ fixt: Fixture..., file: StaticString = #file, line: UInt = #line) {
        for i in 0 ..< fixt.count {
            let fixture = fixt[i]
            applyFixture(parser: parser, name: name, index: i, base: base, fixture, file: file, line: line)
        }
    }

    func applyFixturesNil(parser: Parser, name: String, base: Date, _ fixt: Fixture..., file: StaticString = #file, line: UInt = #line) {
        for i in 0 ..< fixt.count {
            let fixture = fixt[i]
            applyFixtureNil(parser: parser, name: name, index: i, base: base, fixture, file: file, line: line)
        }
    }

    private func applyFixture(parser: Parser, name: String, index: Int, base: Date, _ fixture: Fixture, file: StaticString = #file, line: UInt = #line) {
        do {
            let result = try parser.parse(text: fixture.text, base: base)
            XCTAssertEqual(result.range.location, fixture.index, String(format: "[%@] index #%d", name, index), file: file, line: line)
            XCTAssertEqual(result.text, fixture.phrase, String(format: "[%@] text #%d", name, index), file: file, line: line)
            if let diff = fixture.diff {
                XCTAssertEqual(Int(round(result.date.timeIntervalSince(base)/3600/24)), diff, String(format: "[%@] diff #%d", name, index), file: file, line: line)
            } else {
                XCTAssertEqual(result.date.timeIntervalSince(base), fixture.diffInterval,  String(format: "[%@] diff #%d", name, index), file: file, line: line)
            }
        } catch {
            switch error {
            case Error.zeroMatches, Error.notApplied: XCTFail(String(format: "[%@] res #%d", name, index), file: file, line: line)
            default: XCTFail(String(format: "[%@] err #%d", name, index), file: file, line: line)
            }
        }
    }
    
    private func applyFixtureNil(parser: Parser, name: String, index: Int, base: Date, _ fixture: Fixture, file: StaticString = #file, line: UInt = #line) {
        do {
            _ = try parser.parse(text: fixture.text, base: base)
            XCTFail(String(format: "[%@] res #%d", name, index), file: file, line: line)
        } catch {
            switch error {
            case Error.zeroMatches, Error.notApplied: break
            default: XCTFail(String(format: "[%@] err #%d", name, index), file: file, line: line)
            }
        }
    }
}
