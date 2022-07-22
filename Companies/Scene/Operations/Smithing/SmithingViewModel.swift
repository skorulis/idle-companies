//  Created by Alexander Skorulis on 20/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class SmithingViewModel: ObservableObject {

    private let operations: OperationService
    private let smithingService: SmithingService
    let inventory: InventoryStore
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var selectedRecipe: SmithingActivity?
    
    init(operations: OperationService,
         smithingService: SmithingService,
         inventory: InventoryStore
    ) {
        self.operations = operations
        self.smithingService = smithingService
        self.inventory = inventory
        
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

extension SmithingViewModel {
    
    var recipes: [SmithingActivity] {
        SmithingActivity.allCases
    }
    
    var maybeProgress: OperationProgress? {
        guard let selected = selectedRecipe else { return nil }
        return operations.active.first { progress in
            return progress.operation.matches(selected)
        }
    }
}

// MARK: - Logic

extension SmithingViewModel {
 
    func recipePressed(_ recipe: SmithingActivity) -> () -> Void {
        return { [unowned self] in
            self.selectedRecipe = recipe
        }
    }
    
    func startSmithing() {
        guard let selected = selectedRecipe else { return }
        operations.start(selected)
    }
    
}
