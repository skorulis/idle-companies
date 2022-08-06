//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

enum RecruitingActivity: String, CaseIterable, POperation, Identifiable {
    
    case streets
    case school
    case university
    case offices
    case techPark
    
}

// MARK: - Computed values

extension RecruitingActivity {
    
    var id: String { rawValue }
    var skill: Skill { .hr }
    
    var name: String {
        return rawValue.capitalized
    }
    
    var baseTime: TimeInterval {
        switch self {
        case .streets: return 5
        case .school: return 10
        case .university: return 10
        case .offices: return 10
        case .techPark: return 10
        }
    }
    
    var baseXP: Int64 {
        return Int64(baseTime)
    }
    
    var outputs: [ItemCount] {
        switch self {
        case .streets:
            return [
                .init(type: .dropout, count: 10),
                .init(type: .laborer, count: 1)
            ]
        case .school:
            return [
                .init(type: .dropout, count: 1),
                .init(type: .laborer, count: 2),
                .init(type: .teacher, count: 2)
            ]
        case .university:
            return [
                .init(type: .dropout, count: 1),
                .init(type: .manager, count: 2),
                .init(type: .engineer, count: 2),
                .init(type: .teacher, count: 2)
            ]
        case .offices:
            return [
                .init(type: .dropout, count: 1),
                .init(type: .laborer, count: 1),
                .init(type: .engineer, count: 1),
                .init(type: .manager, count: 2)
            ]
        case .techPark:
            return [
                .init(type: .dropout, count: 2),
                .init(type: .engineer, count: 2),
                .init(type: .manager, count: 1)
            ]
        }
    }
    
    var outputPercentages: [ItemPercentage] {
        return ItemRecipe.outputPercentages(outputs)
    }
}
