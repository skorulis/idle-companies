//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

public protocol POperation {
    
    var id: String { get }
    var name: String { get }
    var baseTime: TimeInterval { get }
    var baseXP: Int64 { get }
    var skill: Skill { get }
    
    func matches(_ op: POperation) -> Bool
    
}

extension POperation {
    
    func matches(_ op: POperation) -> Bool {
        return self.skill == op.skill && self.id == op.id
    }
    
}
