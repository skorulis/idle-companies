//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

/// Operations that can be done
public enum Skill: String, Identifiable {
    case mining
    case smithing
    
    public var id: String { rawValue }
}

extension Skill {
 
    var name: String {
        switch self {
        case .mining: return "Mining"
        case .smithing: return "Smithing"
        }
    }
    
    var icon: ThemeIcon {
        switch self {
        case .mining: return .digDug
        case .smithing: return .anvil
        }
    }
    
}
