//  Created by Alexander Skorulis on 21/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class MarketingViewModel: ObservableObject {
    
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

extension MarketingViewModel {
    
    var availableOptions: [MarketingType] {
        return [.newspaper, .radio]
    }
}

// MARK: - Logic

extension MarketingViewModel {
    
    func onPress(_ type: MarketingType) -> () -> Void {
        return { [unowned self] in
            self.operations.start(.agencyMarketing(type))
        }
    }
    
    func maybeProgress(_ type: MarketingType) -> OperationProgress? {
        return operations.active.first { progress in
            switch progress.operation {
            case .agencyMarketing(let opType):
                return opType == type
            default:
                return false
            }
        }
    }
    
}
