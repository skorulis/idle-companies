//  Created by Alexander Skorulis on 12/8/2022.

import Foundation

enum MilitarySubType: String, CaseIterable, Identifiable, MenuButtonItem {
    case training
    
    var name: String {
        String(describing: self).capitalized
    }
    
    var icon: ThemeIcon {
        switch self {
        case .training: return .graduateCap
        }
    }
    
    var id: String { rawValue }
}
