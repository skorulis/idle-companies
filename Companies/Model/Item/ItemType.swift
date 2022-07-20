//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

public enum ItemType: String, Codable {
    
    // Ores
    case ironOre
    case goldOre
    
    // Ingots
    case ironIngot
    case goldIngot
    
}

extension ItemType {
    
    var icon: ThemeIcon {
        switch self {
        case .ironOre, .goldOre:
            return .ore
        case .ironIngot, .goldIngot:
            return .metalBar
        }
    }
    
    var color: Color {
        switch self {
        case .ironOre:
            return .gray
        case .goldOre:
            return .yellow
        case .ironIngot:
            return .gray
        case .goldIngot:
            return .yellow
        }
    }
    
}
