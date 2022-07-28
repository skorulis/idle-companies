//  Created by Alexander Skorulis on 27/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class ConstructionContractsViewModel: CoordinatedViewModel, ObservableObject {

    private let operations: OperationService
    private var subscribers: Set<AnyCancellable> = []
    
    init(operations: OperationService) {
        self.operations = operations
        super.init()
        operations.objectWillChange
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
        return operations.active.first { progress in
            return progress.operation.matches(type)
        }
    }
}
