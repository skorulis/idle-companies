//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

enum SmithingActivity: String, POperation, Identifiable, CaseIterable {
    
    case brick
    case concrete
    case ironBar
    case goldBar
    
    var skill: Skill { .smithing }
    var id: String { rawValue }
    
}

// MARK: - Activity defintion

extension SmithingActivity {
    
    var name: String { output.name }
    var icon: ThemeIcon { output.icon }
    
    var output: ItemType {
        switch self {
        case .brick: return .brick
        case .concrete: return .concrete
        case .ironBar: return .ironBar
        case .goldBar: return .goldBar
        }
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .brick:
            return 3
        case .concrete:
            return 10
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
        case .brick:
            return [.init(type: .stone, count: 1)]
        case .concrete:
            return [.init(type: .stone, count: 2), .init(type: .limestone, count: 1)]
        case .ironBar:
            return [.init(type: .ironOre, count: 1)]
        case .goldBar:
            return [.init(type: .goldOre, count: 2)]
        }
    }
}
