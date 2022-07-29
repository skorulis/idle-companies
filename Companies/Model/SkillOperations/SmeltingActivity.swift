//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

enum SmeltingActivity: String, POperation, Identifiable, CaseIterable {
    
    case ironBar
    case goldBar
    
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
        }
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .ironBar:
            return 5
        case .goldBar:
            return 10
        }
    }
    
    var baseXP: Int64 {
        return Int64(baseTime)
    }
    
    var inputs: [ItemCount] {
        switch self {
        case .ironBar:
            return [.init(type: .ironOre, count: 1)]
        case .goldBar:
            return [.init(type: .goldOre, count: 2)]
        }
    }
}
