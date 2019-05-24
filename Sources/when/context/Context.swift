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

public struct Context: Equatable {
    public let text: String
    
    /// Accumulator of relative values.
    public var dateOffset: DateOffset?
    public var timeOffset: TimeOffset?
    
    /// Aboslute values.
    public var year, month, day, hour, minute, second: Int?
    
    init(text: String, dateOffset: DateOffset? = nil, timeOffset: TimeOffset? = nil, year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) {
        self.text = text
        self.dateOffset = dateOffset
        self.timeOffset = timeOffset
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    public func time(date: Date, calendar: Calendar) throws -> Date {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        if let year = year {
            components.year = year
        }
        if let month = month {
            components.month = month
        }
        if let day = day {
            components.day = day
        }
        if let hour = hour {
            components.hour = hour
        }
        if let minute = minute {
            components.minute = minute
        }
        if let second = second {
            components.second = second
        }
        
        try dateOffset?.apply(to: &components)
        try timeOffset?.apply(to: &components)
        
        components.calendar = calendar
        
        guard let result = components.date else { throw Error.cannotCalculateDate(context: self, input: date, calendar: calendar, components: components) }
        return result
    }
}
