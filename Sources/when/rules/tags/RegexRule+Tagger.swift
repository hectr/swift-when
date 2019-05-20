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

extension RegexRule {
    public typealias Tagger = (Match) throws -> [DateTimeTag]
    
    public init(calendar: Calendar, regex: NSRegularExpression, strategy: Strategy, tagger: @escaping Tagger) {
        self.init(calendar: calendar,
                  regex: regex,
                  applier: { match, context, options, reference in
                    // 0. parse captures
                    let tags = try tagger(match)
                    guard !tags.isEmpty else { return false }

                    // 1. update context
                    var updated = context
                    for tag in tags {
                        if let hour = tag.getHour(from: options) {
                            updated.hour = hour
                            updated.minute = 0
                        }
                        if let dateOffset = tag.dateOffset {
                            updated.dateOffset = dateOffset
                        }
                        if let timeOffset = tag.timeOffset {
                            updated.timeOffset = timeOffset
                        }
                    }
                    
                    // 2. merge result
                    _ = strategy.mergeContexts(theirs: &context, mine: updated)
                    return true
        })
    }
}
