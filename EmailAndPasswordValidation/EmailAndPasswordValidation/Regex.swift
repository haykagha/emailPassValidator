//
//  Regex.swift
//  EmailAndPasswordValidation
//
//  Created by Hayk Aghavelyan on 08.12.21.
//

import Foundation

struct Regex {
    let name: String
    let desc: String
}

struct RegexFor {
    
    var patterns: [Regex]
    var error: String = ""
    
    mutating func appendPattern(pattern: Regex) {
        patterns.append(pattern)
    }
    
    mutating func validation(of data: String) -> Bool {
        for pattern in patterns {
            let result = data.range(
                of: pattern.name,
                options: .regularExpression )
            if (result == nil) {
                error = pattern.desc
                return false
            }
        }
        return true
    }
}

