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
    case copperOre
    case tinOre
    case ironOre
    case goldOre
    case oil
    case sand
    
    // Ingots
    case copperBar
    case tinBar
    case ironBar
    case goldBar
    case bronzeBar
    
    // Materials
    case brick
    case concrete
    
    // Gems
    
    case quartz
    case diamond
    
}

extension ItemType: Identifiable {
    
    public var id: String { rawValue }
    
    var icon: ThemeIcon {
        switch self {
        case .credits:
            return .moneyStack
        case .ironOre, .goldOre, .coal, .tinOre, .copperOre:
            return .ore
        case .limestone:
            return .stonePile
        case .ironBar, .goldBar, .tinBar, .copperBar, .bronzeBar:
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
        case .quartz:
            return .saphir
        case .diamond:
            return .cutDiamond
        }
    }
    
    var color: Color {
        switch self {
        case .credits: return .green
        case .stone: return .gray
        case .limestone: return .white
        case .coal: return .black
        case .copperOre, .copperBar: return .Item.copper
        case .tinOre, .tinBar: return .Item.tin
        case .ironOre, .ironBar: return .Item.iron
        case .goldOre, .goldBar: return .Item.gold
        case .bronzeBar: return .Item.bronze
        case .brick: return .red
        case .concrete: return .brown
        case .oil: return .black
        case .sand: return .yellow
        case .diamond: return .blue
        case .quartz: return .white
        }
    }
    
    var name: String {
        switch self {
        case .copperOre: return "Copper ore"
        case .tinOre: return "Tin ore"
        case .ironOre: return "Iron ore"
        case .goldOre: return "Gold ore"
        case .copperBar: return "Copper bar"
        case .tinBar: return " Tin bar"
        case .ironBar: return "Iron bar"
        case .goldBar: return "Gold bar"
        case .bronzeBar: return "Bronze bar"
        default:
            return rawValue.capitalized
        }
    }
    
    func bundle(_ count: Int) -> ItemCount {
        return ItemCount(type: self, count: count)
    }
    
}
