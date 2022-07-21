//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

struct SkillExperience: Codable {
    
    /// Total skill XP
    var main: Int64 = 0
    
    /// XP in single operations related to this skill
    var operations: [String: Int64] = [:]
    
    mutating func add(op: String, xp: Int64) {
        let current = operations[op] ?? 0
        operations[op] = current + xp
    }
    
}
