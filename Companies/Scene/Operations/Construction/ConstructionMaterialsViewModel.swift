//  Created by Alexander Skorulis on 29/7/2022.

import Foundation

// MARK: - Memory footprint

final class ConstructionMaterialsViewModel: CoordinatedViewModel, ObservableObject {
    
    let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
}

// MARK: - Computed values

extension ConstructionMaterialsViewModel {
    
    
}
