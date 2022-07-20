//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

public enum ItemType: String, Codable {
    
    // Money
    case credits
    
    // Ores
    case stone
    case ironOre
    case goldOre
    
    // Ingots
    case ironBar
    case goldBar
    
    // Materials
    case bricks
    
}

extension ItemType {
    
    var icon: ThemeIcon {
        switch self {
        case .credits:
            return .woodenCrate
        case .ironOre, .goldOre:
            return .ore
        case .ironBar, .goldBar:
            return .metalBar
        case .stone:
            return .woodenCrate
        case.bricks:
            return .ore
        }
    }
    
    var color: Color {
        switch self {
        case .credits: return .green
        case .stone: return .gray
        case .ironOre: return .orange
        case .goldOre: return .yellow
        case .ironBar: return .orange
        case .goldBar: return .yellow
        case .bricks: return .gray
        }
    }
    
    var name: String {
        switch self {
        case .ironOre: return "Iron ore"
        case .goldOre: return "Gold ore"
        case .ironBar: return "Iron bar"
        case .goldBar: return "Gold bar"
        default:
            return rawValue.capitalized
        }
    }
    
    func bundle(_ count: Int) -> ItemCount {
        return ItemCount(type: self, count: count)
    }
    
}
