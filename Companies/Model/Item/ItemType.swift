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
    
    // Cogs
    case copperCog
    case tinCog
    case ironCog
    case goldCog
    case bronzeCog
    
    // Materials
    case brick
    case concrete
    
    // Gems
    
    case quartz
    case diamond
    
    // Workers
    
    case dropout
    case laborer
    case teacher
    case manager
    case engineer
    
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
        case .ironCog, .goldCog, .tinCog, .copperCog, .bronzeCog:
            return .cog
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
        case .dropout:
            return .dunceCap
        case .laborer:
            return .person
        case .teacher:
            return .graduateCap
        case .manager:
            return .humanPyramid
        case .engineer:
            return .computing
        }
    }
    
    var color: Color {
        switch self {
        case .credits: return .green
        case .stone: return .gray
        case .limestone: return .white
        case .coal: return .black
        case .copperOre, .copperBar, .copperCog: return .Item.copper
        case .tinOre, .tinBar, .tinCog: return .Item.tin
        case .ironOre, .ironBar, .ironCog: return .Item.iron
        case .goldOre, .goldBar, .goldCog: return .Item.gold
        case .bronzeBar, .bronzeCog: return .Item.bronze
        case .brick: return .red
        case .concrete: return .brown
        case .oil: return .black
        case .sand: return .yellow
        case .diamond: return .blue
        case .quartz: return .white
        case .dropout: return .black
        case .laborer: return .black
        case .teacher: return .black
        case .manager: return .black
        case .engineer: return .black
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
    
    var creditValue: Int {
        return 1
    }
    
}
