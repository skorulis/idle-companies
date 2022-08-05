//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

// MARK: - Memory footprint

extension ConstructionMaterialActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
    
}

// MARK: - Logic

extension ConstructionMaterialActivity.Service {
    
    func tryStart(activity: ConstructionMaterialActivity) throws {
        try inventory.consume(inputs: activity.inputs)
    }
    
    func stats(activity: ConstructionMaterialActivity) -> BasicActivityStats {
        return BasicActivityStats(duration: activity.baseTime)
    }
    
    func finish(activity: ConstructionMaterialActivity) throws {
        try inventory.add(item: activity.outputStack)
    }
}
