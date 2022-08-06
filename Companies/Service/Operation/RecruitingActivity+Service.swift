//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

// MARK: - Memory footprint

extension RecruitingActivity {
    
    typealias ServiceType = Service
    
    struct Service: PActivityService {
        private let inventory: InventoryStore
        
        init(inventory: InventoryStore) {
            self.inventory = inventory
        }
    }
    
}

// MARK: - Logic

extension RecruitingActivity.Service {
    func tryStart(activity: RecruitingActivity) throws { }
    
    func stats(activity: RecruitingActivity) -> BasicActivityStats {
        return BasicActivityStats(duration: activity.baseTime)
    }
    
    func finish(activity: RecruitingActivity) throws {
        let item = RecipeService.randomItem(percentages: activity.outputPercentages)
        try inventory.add(item: item, count: 1)
    }
}
