//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

/// Operations that can be done
public enum Skill: String, Identifiable, Codable {
    case mining
    case metallurgy
    case marketing
    
    public var id: String { rawValue }
}

extension Skill {
 
    var name: String {
        switch self {
        case .mining: return "Mining"
        case .metallurgy: return "Metallurgy"
        case .marketing: return "Marketing"
        }
    }
    
    var icon: ThemeIcon {
        switch self {
        case .mining: return .digDug
        case .metallurgy: return .anvil
        case .marketing: return .virtualMarker
        }
    }
    
}
