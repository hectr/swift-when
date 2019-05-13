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

extension Common {
    /*
     - DD/MM/YYYY
     - 11/3/2015
     - 11/3/2015
     - 11/3

     also with "\", gift for windows' users
     */
    public static func buildSlashDMY(strategy: Strategy = .override) -> Rule {
        return RegexRule(
            calendar: calendar,
            regex: regex,
            applier: { match, context, _, reference in
                // 0. parse captures
                guard let day = Int(match.captures[0]) else { throw Error.cannotParseInt(string: match.captures[0]) }
                guard let month = Int(match.captures[1]) else { throw Error.cannotParseInt(string: match.captures[1]) }
                var year: Int = try {
                    if match.captures.count > 2 && !match.captures[2].isEmpty {
                        guard let capturedYear = Int(match.captures[2]) else { throw Error.cannotParseInt(string: match.captures[2]) }
                        return capturedYear
                    } else {
                        return -1
                    }
                }()
                guard day != 0 else { return false }

                // 1. update context
                var updated = context
                guard try self.withYear(context: &updated, reference: reference, year: &year, month: month, day: day, calendar: calendar) else { return false }

                // 2. merge result
                _ = strategy.mergeContexts(theirs: &context, mine: updated)
                return true
        })
    }

    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)" +
        "([0-3]{0,1}[0-9]{1})" +
        "[\\/\\\\]" +
        "([0-3]{0,1}[0-9]{1})" +
        "(?:[\\/\\\\]" +
        "((?:1|2)[0-9]{3})\\s*)?" +
        "(?:\\W|$)")

    private static func withYear(context: inout Context, reference: Date, year: inout Int, month: Int, day: Int, calendar: Calendar) throws -> Bool {
        if year != -1 {
            if try getMonthDays(month: month, year: year) >= day {
                context.year = year
                context.month = month
                context.day = day
            } else {
                return false
            }
            return true
        }

        var components = calendar.dateComponents([.year, .month, .day], from: reference)

        guard let dayComponent = components.day else { throw Error.missingComponent(.day, in: components) }
        guard let monthComponent = components.month else { throw Error.missingComponent(.month, in: components) }
        guard let yearComponent = components.year else { throw Error.missingComponent(.year, in: components) }

        if monthComponent > month {
            year = yearComponent + 1
            return try withYear(context: &context, reference: reference, year: &year, month: month, day: day, calendar: calendar)
        }

        if monthComponent == month {
            if try getMonthDays(month: month, year: yearComponent) >= day {
                if day > dayComponent {
                    year = yearComponent
                } else if day < dayComponent {
                    year = yearComponent + 1
                } else {
                    return false
                }
                return try withYear(context: &context, reference: reference, year: &year, month: month, day: day, calendar: calendar)
            } else {
                return false
            }
        }

        return true
    }
}
