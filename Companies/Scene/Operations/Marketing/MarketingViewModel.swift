//  Created by Alexander Skorulis on 21/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class MarketingViewModel: CoordinatedViewModel, ObservableObject {
    
    private let operations: OperationService
    
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

extension MarketingViewModel {
    
    var availableOptions: [MarketingActivity] {
        return [.newspaper, .radio]
    }
}

// MARK: - Logic

extension MarketingViewModel {
    
    func onPress(_ type: MarketingActivity) -> () -> Void {
        return { [unowned self] in
            self.operations.start(type)
        }
    }
    
    func maybeProgress(_ type: MarketingActivity) -> OperationProgress? {
        return operations.active.first { progress in
            return progress.operation.matches(type)
        }
    }
    
}
