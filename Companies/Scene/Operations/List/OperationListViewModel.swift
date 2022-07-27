//  Created by Alexander Skorulis on 18/7/2022.

import Foundation

// MARK: - Memory footprint

final class OperationListViewModel: CoordinatedViewModel, ObservableObject {
    
}

// MARK: - Computed values

extension OperationListViewModel {
    
    var available: [Skill] {
        return [.mining, .marketing, .metallurgy, .construction]
    }
    
}

// MARK: - Logic

extension OperationListViewModel {
    
    func show(_ skill: Skill) -> () -> Void {
        return { [unowned self] in
            coordinator.push(OperationPath.skillRoot(skill))
        }
    }
        
}
