//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

struct MiningService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
    func onFinish(_ place: MiningActivity) {
        let item = RecipeService.randomItem(percentages: place.outputPercentages)
        inventory.add(item: item, count: 1)
    }
    
    func duration(_ type: MiningActivity) -> TimeInterval {
        return type.baseTime
    }
    
}
