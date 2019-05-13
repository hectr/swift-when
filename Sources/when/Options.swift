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

public struct Options: Equatable {
    public let afternoon, evening, morning, noon: Int
    public let maxDistance: Int // maximum clustering distance for matches within the same result
    public let matchByOrder: Bool

    public init(afternoon: Int = 15, evening: Int = 18, morning: Int = 8, noon: Int = 12, maxDistance: Int = 5, matchByOrder: Bool = true) {
        self.afternoon = afternoon
        self.evening = evening
        self.morning = morning
        self.noon = noon
        self.maxDistance = maxDistance
        self.matchByOrder = matchByOrder
    }
}

/// Default options for internal usage.
public var defaultOptions = Options()
