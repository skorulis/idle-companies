//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

final class MarketingService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
    func onFinish(_ type: MarketingActivity) {
        inventory.add(item: .credits, count: type.baseProfit)
    }
    
    func duration(_ type: MarketingActivity) -> TimeInterval {
        return type.baseTime
    }
    
}
