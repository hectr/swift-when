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

extension RuleFactory {
    public static var calendar: Calendar {
        return Calendar(identifier: .gregorian)
    }

    public static var weekdayOffset: [String: Int] {
        var offsets = [String: Int]()
        insertLowercasedElements(from: calendar.weekdaySymbols, into: &offsets)
        insertLowercasedElements(from: calendar.shortWeekdaySymbols, into: &offsets)
        insertLowercasedElements(from: calendar.veryShortWeekdaySymbols, into: &offsets)
        insertLowercasedElements(from: calendar.standaloneWeekdaySymbols, into: &offsets)
        insertLowercasedElements(from: calendar.shortStandaloneWeekdaySymbols, into: &offsets)
        insertLowercasedElements(from: calendar.veryShortStandaloneWeekdaySymbols, into: &offsets)
        return offsets
    }

    public static var weekdayOffsetPattern: String {
        return buildPattern(for: weekdayOffset)
    }

    public static var monthOffset: [String: Int] {
        var offsets = [String: Int]()
        insertLowercasedElements(from: calendar.monthSymbols, into: &offsets)
        insertLowercasedElements(from: calendar.shortMonthSymbols, into: &offsets)
        insertLowercasedElements(from: calendar.veryShortMonthSymbols, into: &offsets)
        insertLowercasedElements(from: calendar.standaloneMonthSymbols, into: &offsets)
        insertLowercasedElements(from: calendar.shortStandaloneMonthSymbols, into: &offsets)
        insertLowercasedElements(from: calendar.veryShortStandaloneMonthSymbols, into: &offsets)
        return offsets
    }

    public static var monthOffsetPattern: String {
        return buildPattern(for: monthOffset)
    }

    public static var integerWords: [String: Int] {
        return buildWordsForNumbers(from: 1, to: 31, style: .spellOut, locale: calendar.locale)
    }

    public static var integerWordsPattern: String {
        return buildPattern(for: integerWords)
    }

    public static var ordinalWords: [String: Int] {
        return buildWordsForNumbers(from: 1, to: 31, style: .ordinal, locale: calendar.locale)
    }

    public static var ordinalWordsPattern: String {
        return buildPattern(for: ordinalWords)
    }

    public static var relativeDateWords: [String: DateTimeTag] {
        let absoluteFormatter = buildDateFormatter(isRelative: false)
        let relativeFormatter = buildDateFormatter(isRelative: true)
        return buildWordsForRelativeTags(absoluteFormatter: absoluteFormatter,
                                         relativeFormatter: relativeFormatter)
    }

    public static var relativeDateWordsPattern: String {
        return buildPattern(for: relativeDateWords)
    }

    public static func getMonthDays(month: Int, year: Int) throws -> Int {
        let components = DateComponents(calendar: calendar,
                                        timeZone: calendar.timeZone,
                                        era: nil,
                                        year: year,
                                        month: month,
                                        day: nil,
                                        hour: nil,
                                        minute: nil,
                                        second: nil,
                                        nanosecond: nil,
                                        weekday: nil,
                                        weekdayOrdinal: nil,
                                        quarter: nil,
                                        weekOfMonth: nil,
                                        weekOfYear: nil,
                                        yearForWeekOfYear: nil)
        guard let date = calendar.date(from: components) else { throw Error.cannotCreateDate(year: year, month: month, calendar: calendar) }
        guard let monthRange = calendar.range(of: .day, in: .month, for: date) else { throw Error.cannotCalculateRange(smaller: .day, larger: .month, date: date) }
        let daysInMonth = monthRange.count
        return daysInMonth
    }

    private static func insertLowercasedElements(from array: [String], into offsetsDictionary: inout [String: Int]) {
        for index in 0 ..< array.count {
            let key = array[index].lowercased()
            offsetsDictionary[key] = index + 1
        }
    }

    private static func buildPattern(for dictionary: [String: Any]) -> String {
        let keys = Array(dictionary.keys)
        return keys
            .map { NSRegularExpression.escapedPattern(for: $0) }
            .joined(separator: "|")
            .prepending("(?:")
            .appending(")")
    }

    private static func buildWordsForNumbers(from: Int, to: Int, style: NumberFormatter.Style, locale: Locale?) -> [String: Int] {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.locale = locale
        var numbers = [String: Int]()
        for number in from ... to {
            guard let word = formatter.string(from: number as NSNumber)?.lowercased() else { continue }
            numbers[word] = number
        }
        return numbers
    }

    private static func buildDateFormatter(isRelative: Bool) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = calendar.locale
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = isRelative
        return formatter
    }

    private static func buildWordsForRelativeTags(absoluteFormatter: DateFormatter, relativeFormatter: DateFormatter) -> [String: DateTimeTag] {
        let relativeTags: [DateTimeTag] = [.dayBeforeYesterday, .yesterday, .today, .tomorrow, .dayAfterTomorrow]
        var tags = [String: DateTimeTag]()
        for tag in relativeTags {
            var components = calendar.dateComponents([.year, .month, .day], from: Date())
            if let dateOffset = tag.dateOffset {
                do {
                    try dateOffset.apply(to: &components)
                } catch { continue }
            }
            if let timeOffset = tag.timeOffset {
                do {
                    try timeOffset.apply(to: &components)
                } catch { continue }
            }
            guard let date = calendar.date(from: components) else { continue }
            let absolute = absoluteFormatter.string(from: date)
            let relative = relativeFormatter.string(from: date)
            guard absolute != relative else { continue }
            let word = relative.lowercased()
            tags[word] = tag
        }
        return tags
    }
}
