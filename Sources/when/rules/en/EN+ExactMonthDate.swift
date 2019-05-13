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
    // {"third of march", "third", "", "march", "", ""}
    // {"march third", "", "", "march", "third", ""}
    // {"march 3rd", "", "", "march", "3rd", ""}
    // {"3rd march", "3rd", "", "march", "", ""}
    // {"march 3", "", "", "march", "", "3"}
    // {"1st of september", "1st", "", "september", "", ""}
    // {"sept. 1st", "", "", "sept.", "1st", ""}
    // {"march 7th", "", "", "march", "7th", ""}
    // {"october 21st", "", "", "october", "21st", ""}
    // {"twentieth of december", "twentieth", "", "december", "", ""}
    // {"march 10th", "", "", "march", "10th", ""}
    // {"jan. 6", "", "", "jan.", "", "6"}
    // {"february", "", "", "february", "", ""}
    // {"october", "", "", "october", "", ""}
    // {"jul.", "", "", "jul.", "", ""}
    // {"june", "", "", "june", "", ""}
    public static func buildExactMonthDate(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, reference in
                // 0. parse captures
                let ord1 = match
                    .captures[0]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                let num1 = match
                    .captures[1]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                let mon = match
                    .captures[2]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                let ord2 = match
                    .captures[3]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                let num2 = match
                    .captures[4]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                guard let monInt = monthOffset[mon] else { return false }

                // 1. update context
                var updated = context
                updated.month = monInt
                if !ord1.isEmpty {
                    guard let ordInt = ordinalWords[ord1] else { return false }
                    updated.day = ordInt
                }
                if !num1.isEmpty {
                    guard let num = Int(num1) else { return false }
                    updated.day = num
                }
                if !ord2.isEmpty {
                    guard let ordInt = ordinalWords[ord2] else { return false }
                    updated.day = ordInt
                }
                if !num2.isEmpty {
                    guard let num = Int(num2) else { return false }
                    updated.day = num
                }

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })
    }

    // 1. - ordinal day?
    // 2. - numeric day?
    // 3. - month
    // 4. - ordinal day?
    // 5. - ordinal day?
    private static let regex = try! NSRegularExpression(pattern: "(?i)" +
        "(?:\\W|^)" +
        "(?:(?:(" + String(ordinalWordsPattern.dropFirst(3)) + "(?:\\s+of)?|([0-9]+))\\s*)?" +
        "(" + String(monthOffsetPattern.dropFirst(3)) + // skip '(?:'
        "(?:\\s*(?:(" + String(ordinalWordsPattern.dropFirst(3)) + "|([0-9]+)))?" +
        "(?:\\W|$)")
}
