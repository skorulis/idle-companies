//  Created by Alexander Skorulis on 13/8/2022.

import Foundation

struct MilitaryTrainingActivity: POperation {
    
    let targetBattalion: Int
    let inputType: ItemType
    
    init(targetBattalion: Int, inputType: ItemType) {
        self.targetBattalion = targetBattalion
        self.inputType = inputType
    }
    
    var id: String {
        return "MilitaryTrainingActivity\(inputType)-\(targetBattalion)"
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
        return [.init(type: inputType, count: 1)]
    }
    
    var soldier: Soldier {
        return .init(accuracy: 5, damage: 10, armor: 4, range: 10, speed: 10)
    }
    
}
