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

extension RuleFactory {
    public static func buildTaggerRule(taggedWords: [String: [DateTimeTag]], regex customRegex: NSRegularExpression? = nil, strategy: Strategy = .override) -> Rule {
        let regex: NSRegularExpression
        if let customRegex = customRegex {
            regex = customRegex
        } else {
            let pattern = Array(taggedWords.keys)
                .map { NSRegularExpression.escapedPattern(for: $0) }
                .joined(separator: "|")
                .prepending("(")
                .appending(")")
                .replacingOccurrences(of: " ", with: "\\s+")
            regex = try! NSRegularExpression(pattern: "(?i)"
                + "(?:\\W|^)"
                + pattern
                + "(?:\\W|$)")
        }
        return RegexRule(
            calendar: calendar,
            regex: regex,
            strategy: strategy,
            tagger: { match in
                // 0. parse captures
                let lower = match
                    .text
                    .components(separatedBy: .whitespacesAndNewlines)
                    .filter { !$0.isEmpty }
                    .joined(separator: " ")
                    .lowercased()
                
                // 1. extract tags
                var words = [DateTimeTag]()
                for (word, tags) in taggedWords {
                    guard lower.contains(word: word) else { continue }
                    words.append(contentsOf: tags)
                }
                return words
        })
    }
}
