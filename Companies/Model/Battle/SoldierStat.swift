//
//  SoldierStat.swift
//  Companies
//
//  Created by Alexander Skorulis on 11/8/2022.
//

import Foundation

enum SoldierStat: String, CaseIterable, Codable, Identifiable {
    case accuracy, damage, armor, range, speed
    
    var id: String { rawValue }
}

extension SoldierStat {
    static var emptyDict: [SoldierStat: Double] {
        return [
            .accuracy: 0,
            .speed: 0,
            .damage: 0,
            .armor: 0,
            .range: 0
        ]
    }
}

extension SoldierStat {
    
    var icon: ThemeIcon {
        switch self {
        case .accuracy:
            return .onTarget
        case .damage:
            return .backPain
        case .armor:
            return .armorVest
        case .range:
            return .bowman
        case .speed:
            return .runningShoe
        }
    }
}
