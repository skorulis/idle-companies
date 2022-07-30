//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

// MARK: - Memory footprint

extension MarketingActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
}

// MARK: - Logic

extension MarketingActivity.Service {
    
    func finish(activity: MarketingActivity) {
        inventory.add(item: .credits, count: activity.baseProfit)
    }
    
    func stats(activity: MarketingActivity) -> BasicActivityStats {
        BasicActivityStats(duration: activity.baseTime)
    }
    
}
