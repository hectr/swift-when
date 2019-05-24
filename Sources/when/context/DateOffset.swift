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

public struct DateOffset: Equatable {
    let years: Int
    let months: Int
    let days: Int
    
    init(years: Int = 0, months: Int = 0, weeksOfMonth: Int = 0, days: Int = 0) {
        self.years = years
        self.months = months
        self.days = days
    }
    
    func adding(years: Int = 0, months: Int = 0, weeksOfMonth: Int = 0, days: Int = 0) -> DateOffset {
        return DateOffset(years: self.years + years,
                          months: self.months + months,
                          days: self.days + days)
    }
    
    func apply(to dateComponents: inout DateComponents) throws {
        guard let year = dateComponents.year else { throw Error.missingComponent(.year, in: dateComponents) }
        dateComponents.year = year + years
        guard let month = dateComponents.month else { throw Error.missingComponent(.month, in: dateComponents) }
        dateComponents.month = month + months
        guard let day = dateComponents.day else { throw Error.missingComponent(.day, in: dateComponents) }
        dateComponents.day = day + days
    }
}
