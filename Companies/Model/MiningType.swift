//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

/// A type of mining operation that can be done
public enum MiningType: String, Identifiable {
    
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
        }
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .iron:
            return 5
        case .gold:
            return 10
        }
    }
    
}
