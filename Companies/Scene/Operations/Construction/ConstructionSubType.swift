//  Created by Alexander Skorulis on 27/7/2022.

import Foundation

enum ConstructionSubType: String, CaseIterable, Identifiable {
    case contracts, materials, buildings
    
    var name: String {
        String(describing: self).capitalized
    }
    
    var icon: ThemeIcon {
        switch self {
        case .contracts: return .checklist
        case .materials: return .concreteBag
        case .buildings: return .blockHouse
        }
    }
    
    var id: String { rawValue }
}
