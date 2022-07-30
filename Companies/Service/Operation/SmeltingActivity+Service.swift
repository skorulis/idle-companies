//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

// MARK: - Memory footprint

extension SmeltingActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
    
}

// MARK: - Logic

extension SmeltingActivity.Service {
    
    func tryStart(activity: SmeltingActivity) throws {
        try inventory.consume(inputs: activity.inputs)
    }
    
    func stats(activity: SmeltingActivity) -> BasicActivityStats {
        return BasicActivityStats(duration: activity.baseTime)
    }
    
    func finish(activity: SmeltingActivity) {
        let output = ItemCount(type: activity.output, count: 1)
        inventory.add(item: output)
    }
}
