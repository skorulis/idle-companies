//  Created by Alexander Skorulis on 29/7/2022.

import Foundation

enum ConstructionMaterialActivity: String, POperation, Identifiable, CaseIterable {
    
    case brick
    case concrete
    
    var skill: Skill { .construction }
    var id: String { rawValue }
}


// MARK: - Activity defintion

extension ConstructionMaterialActivity {
    
    var name: String { output.name }
    var icon: ThemeIcon { output.icon }
    
    var output: ItemType {
        switch self {
        case .brick: return .brick
        case .concrete: return .concrete
        }
    }
    
    var outputStack: ItemCount {
        return ItemCount(type: output, count: 1)
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .brick:
            return 3
        case .concrete:
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
        }
    }
}
