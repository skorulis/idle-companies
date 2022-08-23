//  Created by Alexander Skorulis on 13/8/2022.

import Foundation

extension MilitaryTrainingActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
}

// MARK: - Logic

extension MilitaryTrainingActivity.Service {
    
    func tryStart(activity: MilitaryTrainingActivity) throws {
        try inventory.consume(inputs: activity.inputs)
    }
    
    func stats(activity: MilitaryTrainingActivity) -> BasicActivityStats {
        return BasicActivityStats(duration: activity.baseTime)
    }
    
    func finish(activity: MilitaryTrainingActivity) throws {
        let existing = inventory.battalions[activity.targetBattalion] ?? Battalion.empty
        let merged = existing.merge(activity.soldier)
        
        inventory.updateBatallion(index: activity.targetBattalion, battalion: merged)
    }
}
