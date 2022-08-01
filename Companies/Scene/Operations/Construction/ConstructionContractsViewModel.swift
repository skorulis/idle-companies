//  Created by Alexander Skorulis on 27/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class ConstructionContractsViewModel: CoordinatedViewModel, ObservableObject {

    private let operations: OperationService
    
    init(operations: OperationService) {
        self.operations = operations
        super.init()
        operations.store.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension ConstructionContractsViewModel {
    
    var options: [ConstructionContractActivity] {
        return ConstructionContractActivity.allCases
    }
}

// MARK: - Logic

extension ConstructionContractsViewModel {
 
    func start(_ activity: ConstructionContractActivity) -> () -> Void {
        return { [ unowned self] in
            self.operations.start(activity)
        }
    }
    
    func maybeProgress(_ type: ConstructionContractActivity) -> OperationProgress? {
        operations.store.maybeProgress(type)
    }
}
