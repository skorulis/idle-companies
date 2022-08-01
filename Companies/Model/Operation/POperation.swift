//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

protocol POperation: Codable {
    associatedtype ServiceType: PActivityService where ServiceType.ActivityType == Self
    
    var id: String { get }
    var name: String { get }
    var baseTime: TimeInterval { get }
    var baseXP: Int64 { get }
    var skill: Skill { get }
    
    func matches(_ op: any POperation) -> Bool
    
}

extension POperation {
    
    func matches(_ op: any POperation) -> Bool {
        return self.skill == op.skill && self.id == op.id
    }
    
    static var typeID: String {
        String(describing: type(of: self))
    }
    
}
