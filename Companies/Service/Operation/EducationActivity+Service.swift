//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

// MARK: - Memory footprint

extension EducationActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
    
}

// MARK: - Logic

extension EducationActivity.Service {
    
    func tryStart(activity: EducationActivity) throws {
        try inventory.consume(inputs: activity.inputs)
    }
    
    func stats(activity: EducationActivity) -> BasicActivityStats {
        return BasicActivityStats(duration: activity.baseTime)
    }
    
    func finish(activity: EducationActivity) throws {
        try inventory.add(item: activity.outputStack)
    }
}
