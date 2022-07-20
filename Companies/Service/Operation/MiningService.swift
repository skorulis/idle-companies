//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

struct MiningService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
    func onFinish(_ type: MiningType) {
        let item = type.baseOutput
        inventory.add(item: item, count: 1)
    }
    
    func duration(_ type: MiningType) -> TimeInterval {
        return type.baseTime
    }
    
}
