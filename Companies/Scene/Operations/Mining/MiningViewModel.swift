//  Created by Alexander Skorulis on 17/7/2022.

import Combine
import Foundation

// MARK: - Memory footpring

final class MiningViewModel: CoordinatedViewModel, ObservableObject {
    
    private let operations: OperationService
    let xpCalc: XPLevelCalculation
    private var subscribers: Set<AnyCancellable> = []
    
    init(operations: OperationService,
         xpCalc: XPLevelCalculation
    ) {
        self.operations = operations
        self.xpCalc = xpCalc
        super.init()
        setupObservers()
    }
    
    private func setupObservers() {
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
        
        operations.skillStore.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
    
}

// MARK: - Computed values

extension MiningViewModel {
    
    var availableMining: [MiningActivity] {
        return MiningActivity.allCases
    }
    
    var xp: Int64 {
        operations.skillStore.xp(skill: .mining)
    }
}

// MARK: - Logic

extension MiningViewModel {
    
    func onPress(_ type: MiningActivity) -> () -> Void {
        return { [unowned self] in
            self.operations.start(type)
        }
    }
    
    func maybeProgress(_ place: MiningActivity) -> OperationProgress? {
        return operations.active.first { progress in
            return progress.operation.matches(place)
        }
    }
    
}
