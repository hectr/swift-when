/*
 Original work Copyright 2016 Oleg Lebedev <ole6edev@gmail.com>
 Swift port Copyright 2019, Hèctor Marquès Ranea

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation

/// Result is a struct which contains parsing meta-info.
public struct Result: Equatable {
    /// Whole string processed by the parser.
    public let source: String

    /// Substring of `source` that contains the parsed date.
    public let text: String

    /// Range of `text` in `source`.
    public let range: NSRange

    /// The parsed date.
    public let date: Date

    /// Internal initializer.
    init(index: Int, text: String, source: String, date: Date) {
        assert(index >= 0)
        assert(!text.isEmpty)
        assert(source.contains(text))
        self.source = source
        self.text = text
        self.range = NSRange(location: index, length: text.count)
        self.date = date
        assert(Range(range, in: source) != nil)
    }
}
