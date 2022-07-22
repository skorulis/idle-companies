//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

/// Agency marketing work to generate money
enum MarketingActivity: String, POperation, Identifiable, CaseIterable {
    case newspaper
    case radio
    case television
    case internet
    case subliminal
    
    // TODO: What's sneaky placement called?
    
    var id: String { rawValue }
}

extension MarketingActivity {
    
    var skill: Skill { .marketing }
    var name: String { return rawValue.capitalized }
    
    var baseTime: TimeInterval {
        switch self {
        case .newspaper:
            return 5
        case .radio:
            return 10
        case .television:
            return 30
        case .internet:
            return 60
        case .subliminal:
            return 20
        }
    }
    
    var baseXP: Int64 {
        switch self {
        case .newspaper:
            return 5
        case .radio:
            return 10
        case .television:
            return 30
        case .internet:
            return 60
        case .subliminal:
            return 20
        }
    }
    
    var baseProfit: Int {
        switch self {
        case .newspaper:
            return 1
        case .radio:
            return 2
        case .television:
            return 5
        case .internet:
            return 10
        case .subliminal:
            return 15
        }
    }
}
