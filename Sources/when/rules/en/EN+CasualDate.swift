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
    public static func buildCasualDate(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, _ in
                // 0. parse captures
                let lower = match
                    .text
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                let duration = context.duration ?? 0.0
                let oneDay: TimeInterval = 24 * 3600

                // 1. update context
                var updated = context
                switch lower {
                case let string where string.contains("now"):
                    // updated.duration = 0
                    break
                case let string where string.contains("tonight"):
                    updated.hour = 23
                    updated.minute = 0
                case let string where string.contains("today"):
                    // updated.hour = 18
                    break
                case let string where string.contains("tomorrow") || string.contains("tmr"):
                    updated.duration = duration + oneDay
                case let string where string.contains("yesterday"):
                    let duration = updated.duration ?? 0.0
                    updated.duration = duration - oneDay
                case let string where string.contains("last night"):
                    updated.hour = 23
                    updated.duration = duration - oneDay
                default:
                    return false
                }

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })

    }

    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)(now|today|tonight|last\\s*night|(?:tomorrow|tmr|yesterday)\\s*|tomorrow|tmr|yesterday)(?:\\W|$)")
}
