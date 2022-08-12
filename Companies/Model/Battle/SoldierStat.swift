//
//  SoldierStat.swift
//  Companies
//
//  Created by Alexander Skorulis on 11/8/2022.
//

import Foundation

enum SoldierStat: CaseIterable {
    case accuracy, damage, armor, range, speed
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
