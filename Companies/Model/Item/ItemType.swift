//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

public enum ItemType: String, Codable {
    
    // Money
    case credits
    
    // Mining products
    case stone
    case limestone
    case coal
    case ironOre
    case goldOre
    case oil
    case sand
    
    // Ingots
    case ironBar
    case goldBar
    
    // Materials
    case brick
    case concrete
    
}

extension ItemType {
    
    var icon: ThemeIcon {
        switch self {
        case .credits:
            return .moneyStack
        case .ironOre, .goldOre, .coal:
            return .ore
        case .limestone:
            return .stonePile
        case .ironBar, .goldBar:
            return .metalBar
        case .stone:
            return .stonePile
        case.brick:
            return .clayBrick
        case .concrete:
            return .concreteBag
        case .oil:
            return .oilDrum
        case .sand:
            return .sandDust
        }
    }
    
    var color: Color {
        switch self {
        case .credits: return .green
        case .stone: return .gray
        case .limestone: return .white
        case .coal: return .black
        case .ironOre: return .orange
        case .goldOre: return .yellow
        case .ironBar: return .orange
        case .goldBar: return .yellow
        case .brick: return .red
        case .concrete: return .brown
        case .oil: return .black
        case .sand: return .yellow
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
