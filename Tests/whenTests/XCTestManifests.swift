import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(whenTests.allTests),
        testCase(CommonSlashDMYTests.allTests),
        testCase(CommonSimpleFourDigitsYearTests.allTests),
        testCase(ENWeekdayTests.allTests),
        testCase(ENCasualDateTests.allTests),
        testCase(ENCasualTimeTests.allTests),
        testCase(ENCasualDateTimeTests.allTests),
        testCase(ENHourTests.allTests),
        testCase(ENHourMinuteTests.allTests),
        testCase(ENDeadlineTests.allTests),
        testCase(ENPastTimeTests.allTests),
        testCase(ENExactMonthTestTests.allTests),
        testCase(ENTests),
    ]
}
#endif
