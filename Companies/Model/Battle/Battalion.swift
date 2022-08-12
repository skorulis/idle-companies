//  Created by Alexander Skorulis on 11/8/2022.

import Foundation

struct Battalion {
    let baseStats: [SoldierStat: Double]
    let count: Int
    
    init(solider: Soldier) {
        self.baseStats = solider.stats.mapValues { Double($0) }
        self.count = 1
    }
    
    init(stats: [SoldierStat: Double], count: Int) {
        self.baseStats = stats
        self.count = count
    }
    
    func merge(_ soldier: Soldier) -> Battalion {
        if count == 0 {
            return .init(solider: soldier)
        }
        let doubleCount = Double(count)
        
        var totalStats = SoldierStat.emptyDict
        for stat in SoldierStat.allCases {
            let value = (doubleValue(stat) * doubleCount) + Double(soldier.value(stat))
            totalStats[stat] = value
        }
        
        let newCount = doubleCount + 1
        let newStats = totalStats.mapValues { $0 / newCount }
        return Battalion(stats: newStats, count: count + 1)
    }
    
    func doubleValue(_ stat: SoldierStat) -> Double {
        return baseStats[stat] ?? 0
    }
    
    func value(_ stat: SoldierStat) -> Int {
        return Int(round(doubleValue(stat)))
    }
    
}
