//  Created by Alexander Skorulis on 27/7/2022.

import Foundation

enum ConstructionContractActivity: String, POperation, Identifiable, CaseIterable {
    case apprenticing
    case labouring
    case roofing
    case carpentry
    
    var id: String { rawValue }
}

extension ConstructionContractActivity {
    
    var skill: Skill { .construction }
    var name: String { return rawValue.capitalized }
    
    var baseTime: TimeInterval {
        return 10
    }
    
    var baseXP: Int64 {
        switch self {
        case .apprenticing:
            return 10
        case .labouring:
            return 5
        case .roofing:
            return 8
        case .carpentry:
            return 10
        }
    }
    
    var baseProfit: Int {
        switch self {
        case .apprenticing:
            return 1
        case .labouring:
            return 3
        case .roofing:
            return 3
        case .carpentry:
            return 10
        }
    }
}
