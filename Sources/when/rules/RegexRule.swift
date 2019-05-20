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

/// Concrete implementation of `Rule` that uses a regular expression to find matches.
public struct RegexRule: Rule {
    public let calendar: Calendar

    private let regex: NSRegularExpression
    private let applier: Match.Applier

    public init(calendar: Calendar, regex: NSRegularExpression, applier: @escaping Match.Applier) {
        self.calendar = calendar
        self.regex = regex
        self.applier = applier
    }

    public func find(_ text: String) -> Match? {
        var matchLeft = Int.max
        var matchRight = Int.min
        var matchCaptures: [String] = []

        let fullTextNSRange = NSRange(location: 0, length: text.count)
        let results = regex.matches(in: text, options: [], range: fullTextNSRange)
        let ranges = findRanges(results)

        for nsRange in ranges {
            if matchLeft > nsRange.lowerBound {
                matchLeft = nsRange.lowerBound
            }
            if matchRight < nsRange.upperBound {
                matchRight = nsRange.upperBound
            }
            guard let range = Range(nsRange, in: text) else { continue }
            matchCaptures.append(String(text[range]))
        }

        guard !matchCaptures.isEmpty else { return nil }

        let matchNSRange = NSRange(location: matchLeft, length: matchRight - matchLeft)
        guard let matchRange = Range(matchNSRange, in: text) else { return nil }

        return Match(left: matchLeft,
                     right: matchRight,
                     text: String(text[matchRange]),
                     captures: matchCaptures,
                     order: Int.max,
                     applier: applier)
    }

    private func findRanges(_ results: [NSTextCheckingResult]) -> [NSRange] {
        for result in results {
            let ranges = findRanges(in: result)
            guard !ranges.isEmpty else { continue }
            return ranges
        }
        return []
    }

    private func findRanges(in result: NSTextCheckingResult) -> [NSRange] {
        if result.numberOfRanges == 0 {
            // without capture groups:
            // - use whole range
            return [result.range]
        } else {
            // with capture groups:
            // - skip whole regex range
            // - skip not found range
            var ranges = [NSRange]()
            let indexOfFirstCaptureGroup = 1
            for i in indexOfFirstCaptureGroup ..< result.numberOfRanges {
                let range = result.range(at: i)
                if range.location != NSNotFound {
                    ranges.append(range)
                } else {
                    // empty string
                    ranges.append(NSRange(location: ranges.last?.location ?? 0, length: 0))
                }
            }
            return ranges
        }
    }
}
