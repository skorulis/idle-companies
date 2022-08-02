//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

enum SmeltingActivity: String, POperation, Identifiable, CaseIterable {
    
    case ironBar
    case goldBar
    case bronzeBar
    
    var skill: Skill { .metallurgy }
    var id: String { rawValue }
    
}

// MARK: - Activity defintion

extension SmeltingActivity {
    
    var name: String { output.name }
    var icon: ThemeIcon { output.icon }
    
    var output: ItemType {
        switch self {
        case .ironBar: return .ironBar
        case .goldBar: return .goldBar
        case .bronzeBar: return .bronzeBar
        }
    }
    
    var count: Int {
        switch self {
        case .bronzeBar: return 2
        default: return 1
        }
    }
    
    var outputCount: ItemCount {
        return ItemCount(type: output, count: count)
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .ironBar:
            return 5
        case .goldBar:
            return 10
        case .bronzeBar:
            return 20
        }
    }
    
    var baseXP: Int64 {
        return Int64(baseTime)
    }
    
    var inputs: [ItemCount] {
        switch self {
        case .ironBar:
            return [.init(type: .ironOre, count: 2)]
        case .goldBar:
            return [.init(type: .goldOre, count: 2)]
        case .bronzeBar:
            return [
                .init(type: .copperOre, count: 5),
                .init(type: .tinOre, count: 1),
            ]
        }
    }
}
