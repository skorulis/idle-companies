//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

enum MiningOperation: String, CaseIterable, OperationInfo, Identifiable {

    case beach
    case rock
    case iron
    case tarSands
    
}

// MARK: - Computed values

extension MiningOperation {
    
    var id: String { rawValue }
    
    var name: String {
        switch self {
        case .beach: return "Beach Quarry"
        case .rock: return "Rock Quarry"
        case .iron: return "Iron mine"
        case .tarSands: return "Tar sands"
        }
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .beach: return 5
        case .rock: return 5
        case .iron: return 7
        case .tarSands: return 10
        }
    }
    
    var baseXP: Int64 {
        switch self {
        case .beach: return 5
        case .rock: return 5
        case .iron: return 7
        case .tarSands: return 11
        }
    }
    
    var outputs: [ItemCount] {
        switch self {
        case .beach:
            return [
                .init(type: .limestone, count: 2),
                .init(type: .stone, count: 1)
            ]
        case .rock:
            return [
                .init(type: .stone, count: 2),
                .init(type: .coal, count: 1)
            ]
        case .iron:
            return [
                .init(type: .ironOre, count: 5),
                .init(type: .stone, count: 2),
                .init(type: .coal, count: 1)
            ]
        case .tarSands:
            return [
                .init(type: .oil, count: 3)
            ]
        }
    }
    
    var outputPercentages: [ItemPercentage] {
        return ItemRecipe.outputPercentages(outputs)
    }
}
