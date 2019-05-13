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
     "5pm"
     "5 pm"
     "5am"
     "5pm"
     "5A."
     "5P."
     "11 P.M."
     */
    public static func buildHour(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, _ in
                // 0. parse captures
                guard let hour = Int(match.captures[0]) else { throw Error.cannotParseInt(string: match.captures[0]) }
                guard hour <= 12 else { return false }

                // 1. update context
                var updated = context
                switch match.captures[1].lowercased().first {
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
                updated.minute = 0

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })
    }

    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)" +
        "(\\d{1,2})" +
        "(?:\\s*(A\\.|P\\.|A\\.M\\.|P\\.M\\.|AM?|PM?))" +
        "(?:\\W|$)")
}
