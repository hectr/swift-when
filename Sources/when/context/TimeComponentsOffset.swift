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

public struct TimeComponentsOffset: Equatable {
    let seconds: Int
    let minutes: Int
    let hours: Int

    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }

    func adding(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> TimeComponentsOffset {
        return TimeComponentsOffset(hours: self.hours + hours,
                                    minutes: self.minutes + minutes,
                                    seconds: self.seconds + seconds)
    }
}
