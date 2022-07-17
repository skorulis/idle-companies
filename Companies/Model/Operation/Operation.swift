//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

public enum Operation {
    case mining(_ type: MiningType)
}

public extension Operation {
    
    var skill: Skill {
        switch self {
        case .mining:
            return .mining
        }
    }
}
