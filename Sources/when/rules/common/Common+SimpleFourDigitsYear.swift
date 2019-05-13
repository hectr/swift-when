/*
 Copyright 2019, Hèctor Marquès Ranea

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

extension Common {
    public static func buildSimpleFourDigitsYear(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, reference in
                // 0. parse captures
                guard let year = Int(match.captures[0]) else { throw Error.cannotParseInt(string: match.captures[0]) }

                // 1. update context
                var updated = context
                updated.year = year

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })
    }

    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)\\s*" +
        "([0-9][0-9][0-9][0-9])\\s*" +
        "(?:\\W|$)")
}
