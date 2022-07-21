//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

/// A type of mining operation that can be done
public enum MiningType: String, Identifiable {
    
    case stone
    case coal
    case iron
    case gold
    
    
    public var id: String { rawValue }
    
}

public extension MiningType {
    
    var name: String {
        switch self {
        case .iron:
            return "Iron"
        case .gold:
            return "Gold"
        default:
            return rawValue.capitalized
        }
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .stone:
            return 4
        case .coal:
            return 6
        case .iron:
            return 5
        case .gold:
            return 10
        }
    }
    
    var baseOutput: ItemType {
        switch self {
        case .stone: return .stone
        case .coal: return .coal
        case .iron: return .ironOre
        case .gold: return .goldOre
        }
    }
    
}
