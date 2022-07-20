//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

/// Agency marketing work to generate money
public enum MarketingType: String, Identifiable {
    case newspaper
    case radio
    case television
    case internet
    case subliminal
    
    // TODO: What's sneaky placement called?
    
    public var id: String { rawValue }
}

extension MarketingType {
    
    var name: String {
        return rawValue.capitalized
    }
    
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
