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

extension EN {
    public static func buildCasualTime(strategy: Strategy = .override) -> Rule {
        return buildTaggerRule(taggedWords: ["morning": [.morning],
                                             "afternoon": [.afternoon],
                                             "evening": [.evening],
                                             "noon": [.noon]],
                               regex: regex)
    }
    
    private static let regex = try! NSRegularExpression(pattern: "(?i)(?:\\W|^)((this)?\\s*(morning|afternoon|evening|noon))")
}
