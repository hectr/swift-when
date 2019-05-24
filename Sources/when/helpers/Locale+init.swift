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

extension Locale {
    public init(languageCode: String? = nil, regionCode: String? = nil, scriptCode: String? = nil, variantCode: String? = nil) {
        let localeIdentifier: String = {
            var identifier = ""
            if let languageCode = languageCode {
                identifier += languageCode
            }
            if let regionCode = regionCode {
                if !identifier.isEmpty {
                    identifier += "-"
                }
                identifier += regionCode
            }
            if let scriptCode = scriptCode {
                if !identifier.isEmpty {
                    identifier += "-"
                }
                identifier += scriptCode
            }
            if let variantCode = variantCode {
                if !identifier.isEmpty {
                    identifier += "_"
                }
                identifier += variantCode
            }
            return identifier
        }()
        self = Locale(identifier: localeIdentifier)
    }
}
