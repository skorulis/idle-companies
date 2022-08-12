//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

/// Operations that can be done
public enum Skill: String, Hashable, Identifiable, Codable {
    case mining
    case metallurgy
    case marketing
    case construction
    case hr
    case military
    
    public var id: String { rawValue }
}

extension Skill {
 
    var name: String {
        switch self {
        case .mining: return "Mining"
        case .metallurgy: return "Metallurgy"
        case .marketing: return "Marketing"
        case .construction: return "Construction"
        case .hr: return "Human resources"
        default: return rawValue.capitalized
        }
    }
    
    var icon: ThemeIcon {
        switch self {
        case .mining: return .digDug
        case .metallurgy: return .anvil
        case .marketing: return .virtualMarker
        case .construction: return .hammerNails
        case .hr: return .person
        case .military: return .targetArrows
        }
    }
    
}
