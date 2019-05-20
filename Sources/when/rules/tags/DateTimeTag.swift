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

public enum DateTimeTag {
    // time of day
    case earlyMorning
    case morning
    case lateMorning
    case noon
    case earlyAfternoon
    case afternoon
    case lateAfternoon
    case earlyEvening
    case evening
    case lateEvening
    case night
    case midnight
    // relative
    case now
    case dayBeforeYesterday
    case yesterday
    case today
    case tomorrow
    case dayAfterTomorrow

    func getHour(from options: Options) -> Int? {
        switch self {
        case .earlyMorning:
            return options.earlyMorning
        case .morning:
            return options.morning
        case .lateMorning:
            return options.lateMorning
        case .noon:
            return options.noon
        case .earlyAfternoon:
            return options.earlyAfternoon
        case .afternoon:
            return options.afternoon
        case .lateAfternoon:
            return options.lateAfternoon
        case .earlyEvening:
            return options.earlyEvening
        case .evening:
            return options.evening
        case .lateEvening:
            return options.lateEvening
        case .night:
            return options.night
        case .midnight:
            return options.midnight
        case .now:
            return nil
        case .dayBeforeYesterday, .yesterday, .today, .tomorrow,
             .dayAfterTomorrow:
            return nil
        }
    }

    var dateOffset: DateComponentsOffset? {
        switch self {
        case .earlyMorning, .morning, .lateMorning, .noon, .earlyAfternoon,
             .afternoon, .lateAfternoon, .earlyEvening, .evening,  .lateEvening,
             .night, .midnight:
            return nil
        case .now:
            return DateComponentsOffset()
        case .dayBeforeYesterday:
            return DateComponentsOffset(days: -2)
        case .yesterday:
            return DateComponentsOffset(days: -1)
        case .today:
            return DateComponentsOffset(days: 0)
        case .tomorrow:
            return DateComponentsOffset(days: 1)
        case .dayAfterTomorrow:
            return DateComponentsOffset(days: 2)
        }
    }

    var timeOffset: TimeComponentsOffset? {
        switch self {
        case .earlyMorning, .morning, .lateMorning, .noon, .earlyAfternoon,
             .afternoon, .lateAfternoon, .earlyEvening, .evening,  .lateEvening,
             .night, .midnight:
            return nil
        case .now:
            return TimeComponentsOffset()
        case .dayBeforeYesterday, .yesterday, .today, .tomorrow,
             .dayAfterTomorrow:
            return nil
        }
    }

}
