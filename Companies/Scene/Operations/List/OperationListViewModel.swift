//  Created by Alexander Skorulis on 18/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class OperationListViewModel: CoordinatedViewModel, ObservableObject {
    
    private let operationService: OperationService
    
    init(operationService: OperationService) {
        self.operationService = operationService
        super.init()
        operationService.store.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
}

// MARK: - Computed values

extension OperationListViewModel {
    
    var available: [Skill] {
        return [.mining, .marketing, .metallurgy, .construction, .hr, .military]
    }
    
}

// MARK: - Logic

extension OperationListViewModel {
    
    func level(_ skill: Skill) -> Int {
        let xp = skillStore.xp(skill: skill)
        return xpCalc.level(xp)
    }
    
    func show(_ skill: Skill) -> () -> Void {
        return { [unowned self] in
            coordinator.push(OperationPath.skillRoot(skill))
        }
    }
    
    func isActive(_ skill: Skill) -> Bool {
        let matching = operationService.store.active.filter { $0.operation.skill == skill}
        return matching.count > 0
    }
        
}
