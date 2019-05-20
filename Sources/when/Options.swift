/*
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

public struct Options: Equatable {
    public let earlyMorning: Int
    public let morning: Int
    public let lateMorning: Int
    public let noon: Int
    public let earlyAfternoon: Int
    public let afternoon: Int
    public let lateAfternoon: Int
    public let earlyEvening: Int
    public let evening: Int
    public let lateEvening: Int
    public let night: Int
    public let midnight: Int

    public let maxDistance: Int // maximum clustering distance for matches within the same result
    public let matchByOrder: Bool

    public init(earlyMorning: Int = 7,
                morning: Int = 8,
                lateMorning: Int = 10,
                noon: Int = 12,
                earlyAfternoon: Int = 13,
                afternoon: Int = 15,
                lateAfternoon: Int = 16,
                earlyEvening: Int = 17,
                evening: Int = 18,
                lateEvening: Int = 21,
                night: Int = 23,
                midnight: Int = 24,
                maxDistance: Int = 5,
                matchByOrder: Bool = true) {
        self.earlyMorning = earlyMorning
        self.morning = morning
        self.lateMorning = lateMorning
        self.noon = noon
        self.earlyAfternoon = earlyAfternoon
        self.afternoon = afternoon
        self.lateAfternoon = lateAfternoon
        self.earlyEvening = earlyEvening
        self.evening = evening
        self.lateEvening = lateEvening
        self.night = night
        self.midnight = midnight
        self.maxDistance = maxDistance
        self.matchByOrder = matchByOrder
    }
}

/// Default options for internal usage.
public var defaultOptions = Options()
