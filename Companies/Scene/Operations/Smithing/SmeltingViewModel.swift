//  Created by Alexander Skorulis on 20/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class SmeltingViewModel: CoordinatedViewModel, ObservableObject {

    private let operations: OperationService
    let inventory: InventoryStore
    
    @Published var selectedRecipe: SmeltingActivity?
    
    init(operations: OperationService,
         inventory: InventoryStore
    ) {
        self.operations = operations
        self.inventory = inventory
        super.init()
        setupObservers()
    }
    
    private func setupObservers() {
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
        
        inventory.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
}

// MARK: - Computed values

extension SmeltingViewModel {
    
    var recipes: [SmeltingActivity] {
        SmeltingActivity.allCases
    }
    
    var maybeProgress: OperationProgress? {
        guard let selected = selectedRecipe else { return nil }
        return operations.active.first { progress in
            return progress.operation.matches(selected)
        }
    }
}

// MARK: - Logic

extension SmeltingViewModel {
 
    func recipePressed(_ recipe: SmeltingActivity) -> () -> Void {
        return { [unowned self] in
            self.selectedRecipe = recipe
        }
    }
    
    func startSmithing() {
        guard let selected = selectedRecipe else { return }
        operations.start(selected)
    }
    
}
