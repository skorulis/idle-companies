//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footpring

final class MiningViewModel: ObservableObject {
    
    private let operations: OperationService
    
    init(operations: OperationService) {
        self.operations = operations
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
    
}
