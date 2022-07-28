//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

enum HQType: String, Codable, CaseIterable, Equatable {
    
    case basic
    case leve1
    case level2
    
}

extension HQType {
    
    var name: String { rawValue.capitalized }
    
    var inventorySpots: Int {
        switch self {
        case .basic:
            return 10
        case .leve1:
            return 20
        case .level2:
            return 30
        }
    }
    
    var requirements: [ItemCount] {
        switch self {
        case .basic:
            fatalError("Can't upgrade to basic")
        case .leve1:
            return [
                .init(type: .brick, count: 100),
                .init(type: .concrete, count: 100)
            ]
        case .level2:
            return [
                .init(type: .brick, count: 500),
                .init(type: .concrete, count: 500)
            ]
        }
    }
    
    var next: HQType? {
        guard let index = Self.allCases.firstIndex(of: self) else {
            return nil
        }
        if index < Self.allCases.count - 1 {
            return Self.allCases[index + 1]
        } else {
            return nil
        }
    }
    
}


