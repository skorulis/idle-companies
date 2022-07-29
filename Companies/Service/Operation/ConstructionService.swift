//  Created by Alexander Skorulis on 27/7/2022.

import Foundation

final class ConstructionService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
    func onFinish(_ type: ConstructionContractActivity) {
        inventory.add(item: .credits, count: type.baseProfit)
    }
    
    func duration(_ type: ConstructionContractActivity) -> TimeInterval {
        return type.baseTime
    }
    
}

// MARK: ConstructionMaterialActivity Handling

extension ConstructionService {
    func start(_ recipe: ConstructionMaterialActivity) throws {
        
    }
    
    func duration(_ activity: ConstructionMaterialActivity) -> TimeInterval {
        return activity.baseTime
    }
    
    func onFinish(_ activity: ConstructionMaterialActivity) {
        inventory.add(item: activity.outputStack)
    }
}
