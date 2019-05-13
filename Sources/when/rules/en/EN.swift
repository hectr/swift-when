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

public struct EN: RuleFactory {
    public static let weekdayOffset = [
        "sunday":    1,
        "sun":       1,
        "monday":    2,
        "mon":       2,
        "tuesday":   3,
        "tue":       3,
        "wednesday": 4,
        "wed":       4,
        "thursday":  5,
        "thur":      5,
        "thu":       5,
        "friday":    6,
        "fri":       6,
        "saturday":  7,
        "sat":       7,
    ]

    public static let weekdayOffsetPattern = "(?:sunday|sun|monday|mon|tuesday|tue|wednesday|wed|thursday|thur|thu|friday|fri|saturday|sat)"

    public static let monthOffset = [
        "january":   1,
        "jan":       1,
        "jan.":      1,
        "february":  2,
        "feb":       2,
        "feb.":      2,
        "march":     3,
        "mar":       3,
        "mar.":      3,
        "april":     4,
        "apr":       4,
        "apr.":      4,
        "may":       5,
        "june":      6,
        "jun":       6,
        "jun.":      6,
        "july":      7,
        "jul":       7,
        "jul.":      7,
        "august":    8,
        "aug":       8,
        "aug.":      8,
        "september": 9,
        "sep":       9,
        "sep.":      9,
        "sept":      9,
        "sept.":     9,
        "october":   10,
        "oct":       10,
        "oct.":      10,
        "november":  11,
        "nov":       11,
        "nov.":      11,
        "december":  12,
        "dec":       12,
        "dec.":      12,
    ]

    public static let monthOffsetPattern = "(?:january|jan\\.?|february|feb\\.?|march|mar\\.?|april|apr\\.?|may|june|jun\\.?|july|jul\\.?|august|aug\\.?|september|sept?\\.?|october|oct\\.?|november|nov\\.?|december|dec\\.?)"

    public static let integerWords = [
        "one":    1,
        "two":    2,
        "three":  3,
        "four":   4,
        "five":   5,
        "six":    6,
        "seven":  7,
        "eight":  8,
        "nine":   9,
        "ten":    10,
        "eleven": 11,
        "twelve": 12,
    ]

    public static let integerWordsPattern = "(?:one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)"

    public static let ordinalWords = [
        "first":          1,
        "1st":            1,
        "second":         2,
        "2nd":            2,
        "third":          3,
        "3rd":            3,
        "fourth":         4,
        "4th":            4,
        "fifth":          5,
        "5th":            5,
        "sixth":          6,
        "6th":            6,
        "seventh":        7,
        "7th":            7,
        "eighth":         8,
        "8th":            8,
        "ninth":          9,
        "9th":            9,
        "tenth":          10,
        "10th":           10,
        "eleventh":       11,
        "11th":           11,
        "twelfth":        12,
        "12th":           12,
        "thirteenth":     13,
        "13th":           13,
        "fourteenth":     14,
        "14th":           14,
        "fifteenth":      15,
        "15th":           15,
        "sixteenth":      16,
        "16th":           16,
        "seventeenth":    17,
        "17th":           17,
        "eighteenth":     18,
        "18th":           18,
        "nineteenth":     19,
        "19th":           19,
        "twentieth":      20,
        "20th":           20,
        "twenty first":   21,
        "twenty-first":   21,
        "21st":           21,
        "twenty second":  22,
        "twenty-second":  22,
        "22nd":           22,
        "twenty third":   23,
        "twenty-third":   23,
        "23rd":           23,
        "twenty fourth":  24,
        "twenty-fourth":  24,
        "24th":           24,
        "twenty fifth":   25,
        "twenty-fifth":   25,
        "25th":           25,
        "twenty sixth":   26,
        "twenty-sixth":   26,
        "26th":           26,
        "twenty seventh": 27,
        "twenty-seventh": 27,
        "27th":           27,
        "twenty eighth":  28,
        "twenty-eighth":  28,
        "28th":           28,
        "twenty ninth":   29,
        "twenty-ninth":   29,
        "29th":           29,
        "thirtieth":      30,
        "30th":           30,
        "thirty first":   31,
        "thirty-first":   31,
        "31st":           31,
    ]

    public static let ordinalWordsPattern = "(?:1st|first|2nd|second|3rd|third|4th|fourth|5th|fifth|6th|sixth|7th|seventh|8th|eighth|9th|ninth|10th|tenth|11th|eleventh|12th|twelfth|13th|thirteenth|14th|fourteenth|15th|fifteenth|16th|sixteenth|17th|seventeenth|18th|eighteenth|19th|nineteenth|20th|twentieth|21st|twenty[ -]first|22nd|twenty[ -]second|23rd|twenty[ -]third|24th|twenty[ -]fourth|25th|twenty[ -]fifth|26th|twenty[ -]sixth|27th|twenty[ -]seventh|28th|twenty[ -]eighth|29th|twenty[ -]ninth|30th|thirtieth|31st|thirty[ -]first)"

    public static let calendar = Locale(identifier: "en").calendar

    public static var all: [Rule] {
        return [
            self.buildWeekday(),
            self.buildCasualDate(),
            self.buildCasualTime(),
            self.buildHour(),
            self.buildHourMinute(),
            self.buildDeadline(),
            self.buildPastTime(),
            self.buildExactMonthDate(),
        ]
    }

    @available(*, unavailable)
    private init() {}
}
