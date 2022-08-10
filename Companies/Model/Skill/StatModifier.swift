//  Created by Alexander Skorulis on 9/8/2022.

import Foundation

struct StatModifier {
    let type: StatType
    let operation: StatOperation
    let amount: Double
    
    static func * (lhs: StatModifier, rhs: Double) -> StatModifier {
        return StatModifier(type: lhs.type, operation: lhs.operation, amount: lhs.amount * rhs)
    }
    
    static func total(type: StatType, mods: [StatModifier]) -> (Double, Double) {
        var add: Double = 0
        var mult: Double = 1
        
        for mod in mods where mod.type == type {
            switch mod.operation {
            case .add:
                add += mod.amount
            case .multiply:
                mult *= mod.amount
            }
        }
        
        return (add, mult)
    }
}

enum StatOperation {
    case add, multiply
}

enum StatType {
    
    case inventorySize
}
