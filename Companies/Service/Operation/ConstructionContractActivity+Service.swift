//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

// MARK: - Memory footprint

extension ConstructionContractActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
}

// MARK: - Logic

extension ConstructionContractActivity.Service {
    
    func finish(activity: ConstructionContractActivity) throws {
        try inventory.add(item: .credits, count: activity.baseProfit)
    }
    
    func stats(activity: ConstructionContractActivity) -> BasicActivityStats {
        BasicActivityStats(duration: activity.baseTime)
    }
    
}
