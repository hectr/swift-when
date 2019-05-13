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

/// Context merge strategy.
public enum Strategy: Equatable, CaseIterable {
    case skip     // omit *mine* if *theirs* already contains any conflicting value
    case merge    // use *mine* only for values not contained in *theirs*
    case override // use all values from *mine* (even `nil` values)

    /// Merges `mine` context into `theirs`; the return indicates whether `theirs` context has changed or not.
    @discardableResult func mergeContexts(theirs: inout Context, mine: Context) -> Bool {
        assert(theirs.text == mine.text)
        switch self {
        case .skip:
            return Strategy.doSkip(theirs: &theirs, mine: mine)
        case .merge:
            return Strategy.doMerge(theirs: &theirs, mine: mine)
        case .override:
            return Strategy.doOverride(theirs: &theirs, mine: mine)
        }
    }

    private static func doSkip(theirs: inout Context, mine: Context) -> Bool {
        guard theirs.year == mine.year       || theirs.year == nil     || mine.year == nil,
            theirs.month == mine.month       || theirs.month == nil    || mine.month == nil,
            theirs.weekday == mine.weekday   || theirs.weekday == nil  || mine.weekday == nil,
            theirs.day == mine.day           || theirs.day == nil      || mine.day == nil,
            theirs.hour == mine.hour         || theirs.hour == nil     || mine.hour == nil,
            theirs.minute == mine.minute     || theirs.minute == nil   || mine.minute == nil,
            theirs.second == mine.second     || theirs.second == nil   || mine.second == nil,
            theirs.duration == mine.duration || theirs.duration == nil || mine.duration == nil else { return false }
        guard theirs != mine else { return false }
        theirs = mine
        return true
    }

    private static func doMerge(theirs: inout Context, mine: Context) -> Bool {
        var updated = false
        if theirs.year == nil {
            updated = true
            theirs.year = mine.year
        }
        if theirs.month == nil {
            updated = true
            theirs.month = mine.month
        }
        if theirs.weekday == nil {
            updated = true
            theirs.weekday = mine.weekday
        }
        if theirs.day == nil {
            updated = true
            theirs.day = mine.day
        }
        if theirs.hour == nil {
            updated = true
            theirs.hour = mine.hour
        }
        if theirs.minute == nil {
            updated = true
            theirs.minute = mine.minute
        }
        if theirs.second == nil {
            updated = true
            theirs.second = mine.second
        }
        if theirs.duration == nil {
            updated = true
            theirs.duration = mine.duration
        }
        return updated
    }

    private static func doOverride(theirs: inout Context, mine: Context) -> Bool {
        guard theirs != mine else { return false }
        theirs = mine
        return true
    }
}
