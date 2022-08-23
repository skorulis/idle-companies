//  Created by Alexander Skorulis on 13/8/2022.

import Foundation

struct MilitaryTrainingActivity: POperation {
    
    let targetBattalion: Int
    
    init(targetBattalion: Int) {
        self.targetBattalion = targetBattalion
    }
    
    var id: String {
        return "MilitaryTrainingActivity-\(targetBattalion)"
    }
    
    var name: String {
        return "Military training"
    }
    
    var baseTime: TimeInterval {
        return 10
    }
    var baseXP: Int64 {
        return 10
    }
    
    var skill: Skill {
        .military
    }
    
    var inputs: [ItemCount] {
        return [.init(type: .laborer, count: 1)]
    }
    
    var soldier: Soldier {
        return .init(accuracy: 5, damage: 10, armor: 4, range: 10, speed: 10)
    }
    
}
