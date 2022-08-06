//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

enum EducationActivity: String, POperation, Identifiable, CaseIterable {
    
    case basic
    case engineering
    case teaching
    case management
    
    var skill: Skill { .hr }
    var id: String { rawValue }
}

// MARK: - Activity defintion

extension EducationActivity {
    
    var name: String { outputStack.type.name }
    var icon: ThemeIcon { outputStack.type.icon }
    
    var outputStack: ItemCount {
        switch self {
        case .basic: return ItemCount(type: .laborer, count: 8)
        case .teaching: return ItemCount(type: .teacher, count: 7)
        case .management: return ItemCount(type: .manager, count: 4)
        case .engineering: return ItemCount(type: .engineer, count: 4)
        }
    }
    
    var baseTime: TimeInterval {
        return 20
    }
    
    var baseXP: Int64 {
        return Int64(baseTime)
    }
    
    var inputs: [ItemCount] {
        switch self {
        case .basic:
            return [.init(type: .teacher, count: 1), .init(type: .dropout, count: 10)]
        case .teaching:
            return [.init(type: .teacher, count: 1), .init(type: .laborer, count: 8)]
        case .engineering, .management:
            return [.init(type: .teacher, count: 1), .init(type: .laborer, count: 5)]
        }
    }
}
