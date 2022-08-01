//  Created by Alexander Skorulis on 18/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class OperationListViewModel: CoordinatedViewModel, ObservableObject {
    
    private let operationService: OperationService
    
    init(operationService: OperationService) {
        self.operationService = operationService
        super.init()
        operationService.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
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
    
    func isActive(_ skill: Skill) -> Bool {
        let matching = operationService.active.filter { $0.operation.skill == skill}
        return matching.count > 0
    }
        
}
