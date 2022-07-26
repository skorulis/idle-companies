//  Created by Alexander Skorulis on 18/7/2022.

import Foundation

// MARK: - Memory footprint

final class OperationListViewModel: CoordinatedViewModel, ObservableObject {
    
}

// MARK: - Computed values

extension OperationListViewModel {
    
    var available: [Skill] {
        return [.mining, .marketing, .metallurgy]
    }
    
}

// MARK: - Logic

extension OperationListViewModel {
    
    func show(_ skill: Skill) -> () -> Void {
        return { [unowned self] in
            coordinator.push(self.path(forSkill: skill))
        }
    }
    
    func path(forSkill: Skill) -> OperationPath {
        switch forSkill {
        case .mining: return .mining
        case .metallurgy: return .metallurgy
        case .marketing: return .marketing
        }
    }
    
}
