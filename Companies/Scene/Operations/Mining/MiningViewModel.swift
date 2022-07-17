//  Created by Alexander Skorulis on 17/7/2022.

import Combine
import Foundation

// MARK: - Memory footpring

final class MiningViewModel: ObservableObject {
    
    private let operations: OperationService
    private var subscribers: Set<AnyCancellable> = []
    
    init(operations: OperationService) {
        self.operations = operations
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
    
}

// MARK: - Computed values

extension MiningViewModel {
    
    var availableMining: [MiningType] {
        return [.iron, .gold]
    }
}

// MARK: - Logic

extension MiningViewModel {
    
    func onPress(_ type: MiningType) -> () -> Void {
        return { [unowned self] in
            self.operations.start(.mining(type))
        }
    }
    
    func maybeProgress(_ type: MiningType) -> OperationProgress? {
        return operations.active.first { progress in
            switch progress.operation {
            case .mining(let opType):
                return opType == type
            }
        }
    }
    
}
