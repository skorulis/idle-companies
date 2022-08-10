//  Created by Alexander Skorulis on 8/8/2022.

import Foundation

// MARK: - Memory footpring

enum Enhancement: String, Hashable, Codable, CaseIterable, Identifiable {
    
    /// Increase warehouse space
    case warehouse
    
    /// Testing
    case testing
    
    var id: String { rawValue }
}

// MARK: - Computed values

extension Enhancement {
    
    var name: String {
        switch self {
        default:
            return self.rawValue.capitalized
        }
    }
    
    var maxLevel: Int {
        switch self {
        case .warehouse:
            return 5
        case .testing:
            return 4
        }
    }
    
    var modifiers: [StatModifier] {
        switch self {
        case .warehouse:
            return [.init(type: .inventorySize, operation: .add, amount: 1)]
        case .testing:
            return []
        }
    }
    
    func cost(level: Int) -> [ItemCount] {
        // TODO: Define cost
        return [
            ItemCount(type: .brick, count: 50)
        ]
    }
    
}
