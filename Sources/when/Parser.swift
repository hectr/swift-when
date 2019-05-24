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

/// Parser is a struct which contains options, rules and middlewares to call.
public struct Parser {
    public typealias Middleware = (String) throws -> String
    
    public let options:    Options
    public let rules:      [Rule]
    public let middleware: [Middleware]

    /// Returns Result and error if any. If have not matches it returns nil, nil.
    public func parse(text source: String, base: Date = Date(), calendar: Calendar = .current) throws -> Result {
        let resultIndex: Int
        let resultText: String
        let resultSource: String = source
        var resultDate: Date = base

        // apply middlewares

        var text = source
        for function in middleware {
            text = try function(text)
        }

        // find...

        var ruleIndex = -1
        let allMatches = rules
            .compactMap { rule -> Match? in // find all matches
                ruleIndex += 1
                guard let match = rule.find(text) else { return nil }
                return match.updatingOrder(to: ruleIndex)
            }
            .sorted { a, b in
                if a.left == b.left {
                    return a.right < b.right
                } else {
                    return a.left < b.left
                }
            }
        guard !allMatches.isEmpty else { throw Error.zeroMatches(rules: rules, text: text) }

        // get borders of the matches

        var end = allMatches[0].right
        resultIndex = allMatches[0].left

        var cluster = [Match]()

         // find a cluster
        for index in 0 ..< allMatches.count {
            let match = allMatches[index]
            if match.left <= end + self.options.maxDistance {
                end = match.right
                cluster.append(match)
            } else {
                break
            }
        }

        let nsRange = NSRange(location: resultIndex, length: end - resultIndex)
        guard let range = Range(nsRange, in: text) else { throw Error.rangeConversionError(range: nsRange, string: text) }
        resultText = String(text[range])

        // apply rules

        if options.matchByOrder {
            cluster.sort { ($0.order ?? Int.max) < ($1.order ?? Int.max) }
        }

        var context = Context(text: resultText)
        var applied = false
        for match in cluster {
            applied = try match.applier(match, &context, options, resultDate) || applied
        }
        guard applied else { throw Error.notApplied(matches: cluster, context: context, options: options, date: resultDate) }

        // build result

        resultDate = try context.time(date: resultDate, calendar: calendar)
        return Result(index: resultIndex,
                      text: resultText,
                      source: resultSource,
                      date: resultDate)
    }

    /// Returns Parser initialised with given options, rules and middleware.
    public init(options: Options = defaultOptions, rules: [Rule], middleware: [Middleware] = []) {
        self.options = options
        self.rules = rules
        self.middleware = middleware
    }
}
