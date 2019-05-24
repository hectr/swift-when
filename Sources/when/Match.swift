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

public struct Match {
    public typealias Applier = (Match, inout Context, Options, Date) throws -> Bool

    public let left: Int
    public let right: Int
    public let text: String
    public let captures: [String]
    public let order: Int? // a lower number denotes higher priority
    public let applier: Applier

    public var string: String { return text }

    public func apply(context: inout Context, options: Options, date: Date) throws -> Bool {
        return try applier(self, &context, options, date)
    }

    public func updatingOrder(to order: Int?) -> Match {
        return Match(left: left,
                     right: right,
                     text: text,
                     captures: captures,
                     order: order,
                     applier: applier)
    }
}
