//  Created by Alexander Skorulis on 29/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class ConstructionMaterialsViewModel: CoordinatedViewModel, ObservableObject {
    
    private let operations: OperationService
    private let uiStore: UIHistoryStore
    
    @Published var selected: ConstructionMaterialActivity
    
    init(operations: OperationService,
         uiStore: UIHistoryStore
    ) {
        self.operations = operations
        self.uiStore = uiStore
        selected =  uiStore.retrieve() ?? ConstructionMaterialActivity.allCases[0]
        super .init()
        setupObservers()
    }
    
    private func setupObservers() {
        operations.store.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension ConstructionMaterialsViewModel {
    
    var maybeProgress: OperationProgress? {
        return operations.store.maybeProgress(selected)
    }
    
    var xp: Int64 {
        skillStore.xp(skill: .construction)
    }
    
}

// MARK: - Logic

extension ConstructionMaterialsViewModel {
    
    func select(_ activity: ConstructionMaterialActivity) {
        self.selected = activity
        uiStore.store(selection: activity)
    }
    
    func start() {
        operations.start(selected)
    }
    
}
