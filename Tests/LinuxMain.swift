import XCTest

import whenTests

var tests = [XCTestCaseEntry]()
tests += whenTests.allTests()
tests += slashDMYTests.allTests()
XCTMain(tests)
