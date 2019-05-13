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

public enum Error: Swift.Error {
    case zeroMatches(rules: [Rule], text: String)
    case notApplied(matches: [Match], context: Context, options: Options, date: Date)

    case cannotCreateDate(year: Int, month: Int, calendar: Calendar)
    case cannotCalculateRange(smaller: Calendar.Component, larger: Calendar.Component, date: Date)
    case cannotCalculateDate(context: Context, input: Date, calendar: Calendar, components: DateComponents)
    case rangeConversionError(range: NSRange, string: String)
    case missingComponent(Calendar.Component, in: DateComponents)
    case cannotParseInt(string: String)

    public var isControlFlowError: Bool {
        switch self {
        case .zeroMatches, .notApplied:
            return true
        case .cannotCreateDate,.cannotCalculateRange, .cannotCalculateDate, .rangeConversionError, .missingComponent, .cannotParseInt:
            return false
        }
    }
}
