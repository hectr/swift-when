// Copyright (c) 2019 Hèctor Marquès Ranea
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import XCTest
@testable import when

class StringWordTests: XCTestCase {
    func testCanMatchWord() {
        let string = "hello word!!"
        XCTAssertTrue(string.contains(word: "hello"))
        XCTAssertTrue(string.contains(word: "word"))
    }

    func testReturnsFalseIfNotMatched() {
        let string = "hello word!!"
        XCTAssertFalse(string.contains(word: "llo"))
        XCTAssertFalse(string.contains(word: "d"))
        XCTAssertFalse(string.contains(word: "o "))
        XCTAssertFalse(string.contains(word: " w"))
    }

    func testCanMatchWhitespace() {
        let string = "hello word!!"
        XCTAssertTrue(string.contains(word: " "))
    }

    func testCannotMatchEmptyString1() {
        let string = "hello word!!"
        XCTAssertFalse(string.contains(word: ""))
    }

    func testCannotMatchEmptyString2() {
        let empty = ""
        XCTAssertFalse(empty.contains(word: ""))
    }


    func testWordCanOccupyWholeString() {
        let hello = "hello"
        XCTAssertTrue(hello.contains(word: hello))
    }

    func testEmptyStringCannotContainWord() {
        let empty = ""
        XCTAssertFalse(empty.contains(word: "hello"))
    }

    func testReplacingWord() {
        let string = "my words: hello word-l!!"
            .replacing(word: "word", with: "universe")
        XCTAssertEqual(string, "my words: hello universe-l!!")
    }

    func testReplacingWordNotFound() {
        let string = "my words: hello word-l!!"
            .replacing(word: "universe", with: "word")
        XCTAssertEqual(string, "my words: hello word-l!!")
    }

    func testCanMatchSymbols() {
        let string = "my words: hello word!!"
        XCTAssertNotNil(string.rangeOf(word: ":"))
        XCTAssertTrue(string.contains(word: "!"))
    }
}
