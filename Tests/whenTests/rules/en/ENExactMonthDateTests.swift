import XCTest
import when

final class ENExactMonthDateTests: XCTestCase {
    let sut = Parser(rules: [EN.buildExactMonthDate()])

    func testComplexCases() {
        applyFixtures(parser: sut,
                      name: "EN.ExactMonthDate",
                      base: january6th2016,
                      Fixture(text: "third of march", index: 0, phrase: "third of march", diffInterval: 1368 * 3600),
                      Fixture(text: "march third", index: 0, phrase: "march third", diffInterval:  1368 * 3600),
                      Fixture(text: "march 3rd", index: 0, phrase: "march 3rd", diffInterval: 1368 * 3600),
                      Fixture(text: "3rd march", index: 0, phrase: "3rd march", diffInterval: 1368 * 3600),
                      Fixture(text: "march 3", index: 0, phrase: "march 3", diffInterval: 1368 * 3600),
                      Fixture(text: "1 sept", index: 0, phrase: "1 sept", diff: 5736 / 24),
                      Fixture(text: "1 sept.", index: 0, phrase: "1 sept.", diff: 5736 / 24),
                      Fixture(text: "1st of september", index: 0, phrase: "1st of september", diff: 5736 / 24),
                      Fixture(text: "sept. 1st", index: 0, phrase: "sept. 1st", diff: 5736 / 24),
                      Fixture(text: "march 7th", index: 0, phrase: "march 7th", diff: 1464 / 24),
                      Fixture(text: "october 21st", index: 0, phrase: "october 21st", diff: 6936 / 24),
                      Fixture(text: "twentieth of december", index: 0, phrase: "twentieth of december", diffInterval: 8376 * 3600),
                      Fixture(text: "march 10th", index: 0, phrase: "march 10th", diffInterval: 1536 * 3600),
                      Fixture(text: "jan. 4", index: 0, phrase: "jan. 4", diffInterval: -48 * 3600),
                      Fixture(text: "february", index: 0, phrase: "february", diffInterval: 744 * 3600),
                      Fixture(text: "october", index: 0, phrase: "october", diff: 6576 / 24),
                      Fixture(text: "jul.", index: 0, phrase: "jul.", diff: 4368 / 24),
                      Fixture(text: "june", index: 0, phrase: "june", diff: 3648 / 24))
    }

    static var allTests = [
        ("testComplexCases", testComplexCases),
    ]
}
