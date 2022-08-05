//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

// MARK: - Memory footprint

extension MiningActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
    
}

// MARK: - Logic

extension MiningActivity.Service {
    func tryStart(activity: MiningActivity) throws { }
    
    func stats(activity: MiningActivity) -> BasicActivityStats {
        return BasicActivityStats(duration: activity.baseTime)
    }
    
    func finish(activity: MiningActivity) throws {
        let item = RecipeService.randomItem(percentages: activity.outputPercentages)
        try inventory.add(item: item, count: 1)
    }
}
