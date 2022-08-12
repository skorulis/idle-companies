//  Created by Alexander Skorulis on 11/8/2022.

import Foundation

struct Soldier {
    let stats: [SoldierStat: Int]
    
    init(stats: [SoldierStat: Int]) {
        self.stats = stats
    }
    
    init(accuracy: Int, damage: Int, armor: Int, range: Int, speed: Int) {
        self.stats = [
            .accuracy: accuracy,
            .damage: damage,
            .armor: armor,
            .range: range,
            .speed: speed
        ]
    }
    
    func value(_ stat: SoldierStat) -> Int {
        return stats[stat] ?? 0
    }
    
}


