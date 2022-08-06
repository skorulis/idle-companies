//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

enum HRSubType: String, CaseIterable, Identifiable {
    case recruiting, training
    
    var name: String {
        String(describing: self).capitalized
    }
    
    var icon: ThemeIcon {
        switch self {
        case .recruiting: return .humanPyramid
        case .training: return .graduateCap
        }
    }
    
    var id: String { rawValue }
}
