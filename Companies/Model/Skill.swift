//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

/// Operations that can be done
public enum Skill: String, Identifiable {
    case mining
    case smelting
    
    public var id: String { rawValue }
}

extension Skill {
 
    var name: String {
        switch self {
        case .mining: return "Mining"
        case .smelting: return "Smelting"
        }
    }
    
}
