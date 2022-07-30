//  Created by Alexander Skorulis on 29/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class ConstructionMaterialsViewModel: CoordinatedViewModel, ObservableObject {
    
    let inventory: InventoryStore
    private let operations: OperationService
    
    @Published var selected: ConstructionMaterialActivity?
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(inventory: InventoryStore,
         operations: OperationService
    ) {
        self.inventory = inventory
        self.operations = operations
        super .init()
        setupObservers()
    }
    
    private func setupObservers() {
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension ConstructionMaterialsViewModel {
    
    var maybeProgress: OperationProgress? {
        return operations.maybeProgress(selected)
    }
    
}

// MARK: - Logic

extension ConstructionMaterialsViewModel {
    
    func select(_ activity: ConstructionMaterialActivity) {
        self.selected = activity
    }
    
    func start() {
        guard let activity = selected else { return }
        operations.start(activity)
    }
    
}
