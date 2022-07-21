//  Created by Alexander Skorulis on 17/7/2022.

import Combine
import Foundation

// MARK: - Memory footpring

final class MiningViewModel: ObservableObject {
    
    private let operations: OperationService
    private let miningService: MiningService
    private var subscribers: Set<AnyCancellable> = []
    
    init(operations: OperationService,
         miningService: MiningService
    ) {
        self.operations = operations
        self.miningService = miningService
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
    
}

// MARK: - Computed values

extension MiningViewModel {
    
    var availableMining: [ItemRecipeOperation] {
        return miningService.locations
    }
}

// MARK: - Logic

extension MiningViewModel {
    
    func onPress(_ type: ItemRecipeOperation) -> () -> Void {
        return { [unowned self] in
            self.operations.start(.mining(type))
        }
    }
    
    func maybeProgress(_ place: ItemRecipeOperation) -> OperationProgress? {
        return operations.active.first { progress in
            switch progress.operation {
            case .mining(let opType):
                return opType.id == place.id
            default:
                return false
            }
        }
    }
    
}
