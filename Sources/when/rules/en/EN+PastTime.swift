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

extension EN {
    public static func buildPastTime(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, reference in
                // 0. parse captures
                let numStr = match.captures[0].trimmingCharacters(in: .whitespaces)
                let num: Int? = try {
                    if let num = integerWords[numStr] {
                        return num
                    } else if numStr == "a" || numStr == "an" {
                        return 1
                    } else if numStr.contains("few") {
                        return 3
                    } else if numStr.contains("half") {
                        return nil // pass
                    } else {
                        guard let num = Int(numStr) else { throw Error.cannotParseInt(string: numStr) }
                        return num
                    }
                    }()
                let exponent = match.captures[1].trimmingCharacters(in: .whitespaces)

                // 1. update context
                var updated = context
                if let num = num {
                    switch exponent {
                    case let string where string.contains("second"):
                        updated.timeOffset = TimeComponentsOffset(seconds: -num)
                    case let string where string.contains("min"):
                        updated.timeOffset = TimeComponentsOffset(minutes: -num)
                    case let string where string.contains("hour"):
                        updated.timeOffset = TimeComponentsOffset(hours: -num)
                    case let string where string.contains("day"):
                        updated.dateOffset = DateComponentsOffset(days: -num)
                    case let string where string.contains("week"):
                        updated.dateOffset = DateComponentsOffset(days: -num * 7)
                    case let string where string.contains("month"):
                        updated.dateOffset = DateComponentsOffset(months: -num)
                    case let string where string.contains("year"):
                        updated.dateOffset = DateComponentsOffset(years: -num)
                    default:
                        return false
                    }
                } else {
                    switch exponent {
                    case let string where string.contains("hour"):
                        updated.timeOffset = TimeComponentsOffset(minutes: -30)
                    case let string where string.contains("day"):
                        updated.timeOffset = TimeComponentsOffset(hours: -12)
                    case let string where string.contains("week"):
                        updated.timeOffset = TimeComponentsOffset(hours: -7 * 12)
                    case let string where string.contains("month"):
                        updated.dateOffset = DateComponentsOffset(days: -14)
                    case let string where string.contains("year"):
                        updated.dateOffset = DateComponentsOffset(months: -6)
                    default:
                        return false
                    }
                }

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })
    }

    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)\\s*" +
        "(" + integerWordsPattern + "|[0-9]+|an?(?:\\s*few)?|half(?:\\s*an?)?)\\s*" +
        "(seconds?|min(?:ute)?s?|hours?|days?|weeks?|months?|years?) (ago)\\s*" +
        "(?:\\W|$)")
}
