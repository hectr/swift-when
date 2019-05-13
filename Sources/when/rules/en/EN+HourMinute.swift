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
    /*
     {"5:30pm", 0, "5:30pm", 0},
     {"5:30 pm", 0, "5:30 pm", 0},
     {"7-10pm", 0, "7-10pm", 0},
     {"5-30", 0, "5-30", 0},
     {"05:30pm", 0, "05:30pm", 0},
     {"05:30 pm", 0, "05:30 pm", 0},
     {"05:30", 0, "05:30", 0},
     {"05-30", 0, "05-30", 0},
     {"7-10 pm", 0, "7-10 pm", 0},
     {"11.10 pm", 0, "11.10 pm", 0},
     */
    public static func buildHourMinute(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, _ in
                // 0. parse captures
                guard let hour = Int(match.captures[0]) else { throw Error.cannotParseInt(string: match.captures[0]) }
                guard let minutes = Int(match.captures[1]) else { throw Error.cannotParseInt(string: match.captures[1]) }
                guard minutes <= 59 else { return false }

                // 1. update context
                var updated = context
                updated.second = 0
                updated.minute = minutes

                if match.captures.count > 2 && !match.captures[2].isEmpty {
                    guard hour <= 12 else { return false }
                    switch match.captures[2].lowercased().first {
                    case "a": // am
                        updated.hour = hour
                    case "p": // pm
                        if hour < 12 {
                            updated.hour = hour + 12
                        } else {
                            updated.hour = hour
                        }
                    default:
                        return false
                    }
                } else {
                    guard hour <= 23 else { return false }
                    updated.hour = hour
                }

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })
    }

    // 1. - int
    // 2. - int
    // 3. - ext?
    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)" +
        "((?:[0-1]{0,1}[0-9])|(?:2[0-3]))" +
        "(?:\\:|：|\\-)" +
        "((?:[0-5][0-9]))" +
        "(?:\\s*(A\\.|P\\.|A\\.M\\.|P\\.M\\.|AM?|PM?))?" +
        "(?:\\W|$)")
}
