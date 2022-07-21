//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

struct MiningService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
    func onFinish(_ place: ItemRecipeOperation) {
        let item = RecipeService.randomItem(recipe: place.recipe)
        inventory.add(item: item, count: 1)
    }
    
    func duration(_ type: ItemRecipeOperation) -> TimeInterval {
        return type.baseTime
    }
    
}
