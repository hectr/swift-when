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
    public static func buildWeekday(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, reference in
                // 0. parse captures
                let day = match
                    .captures[1]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                var norm = match
                    .captures[0] + match.captures[2]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                if norm.isEmpty {
                    norm = "next"
                }
                guard let dayInt = weekdayOffset[day] else { return false }
                let duration = context.duration ?? 0.0
                let components = calendar.dateComponents([.weekday], from: reference)
                guard let weekdayComponent = components.weekday else { throw Error.missingComponent(.weekday, in: components) }

                // 1. update context
                var updated = context
                switch norm {
                case let string where string.contains("past") || string.contains("last"):
                    let diff = weekdayComponent - dayInt
                    if diff > 0 {
                        updated.duration = duration - TimeInterval(days: diff)
                    } else if diff < 0 {
                        updated.duration = duration - TimeInterval(days: 7 + diff)
                    } else {
                        updated.duration = duration - TimeInterval(days: 7)
                    }
                case let string where string.contains("next"):
                    let diff = dayInt - weekdayComponent
                    if diff > 0 {
                        updated.duration = duration + TimeInterval(days: diff)
                    } else if diff < 0 {
                        updated.duration = duration + TimeInterval(days: 7 + diff)
                    } else {
                        updated.duration = duration + TimeInterval(days: 7)
                    }
                case let string where string.contains("this"):
                    if weekdayComponent < dayInt {
                        let diff = dayInt - weekdayComponent
                        if diff > 0 {
                            updated.duration = duration + TimeInterval(days: diff)
                        } else if diff < 0 {
                            updated.duration = duration + TimeInterval(days: 7 + diff)
                        } else {
                            updated.duration = duration + TimeInterval(days: 7)
                        }
                    } else if weekdayComponent > dayInt {
                        let diff = weekdayComponent - dayInt
                        if diff > 0 {
                            updated.duration = duration - TimeInterval(days: diff)
                        } else if diff < 0 {
                            updated.duration = duration - TimeInterval(days: 7 + diff)
                        } else {
                            updated.duration = duration - TimeInterval(days:7)
                        }
                    }
                default:
                    return false
                }

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })

    }

    private static let regex = try! NSRegularExpression(pattern:"(?i)" +
        "(?:\\W|^)" +
        "(?:on\\s*?)?" +
        "(?:(this|last|past|next)\\s*)?" +
        "(" + String(weekdayOffsetPattern.dropFirst(3)) + // skip '(?:'
        "(?:\\s*(this|last|past|next)\\s*week)?" +
        "(?:\\W|$)")
}
