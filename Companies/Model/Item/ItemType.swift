//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

public enum ItemType: String, Codable {
    
    // Ores
    case ironOre
    case goldOre
    
    // Ingots
    case ironBar
    case goldBar
    
}

extension ItemType {
    
    var icon: ThemeIcon {
        switch self {
        case .ironOre, .goldOre:
            return .ore
        case .ironBar, .goldBar:
            return .metalBar
        }
    }
    
    var color: Color {
        switch self {
        case .ironOre:
            return .gray
        case .goldOre:
            return .yellow
        case .ironBar:
            return .gray
        case .goldBar:
            return .yellow
        }
    }
    
    var name: String {
        switch self {
        case .ironOre: return "Iron ore"
        case .goldOre: return "Gold ore"
        case .ironBar: return "Iron bar"
        case .goldBar: return "Gold bar"
        }
    }
    
    func bundle(_ count: Int) -> ItemCount {
        return ItemCount(type: self, count: count)
    }
    
}
