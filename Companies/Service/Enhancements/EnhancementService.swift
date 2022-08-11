//  Created by Alexander Skorulis on 8/8/2022.

import Foundation

// MARK: - Memory footprint

final class EnhancementService {

    private let companyStore: CompanyStore
    private let inventory: InventoryStore
    
    init(companyStore: CompanyStore,
         inventory: InventoryStore
    ) {
        self.companyStore = companyStore
        self.inventory = inventory
    }
    
}

// MARK: - Logic

extension EnhancementService {
    
    func purchase(_ enhancement: Enhancement) {
        guard canPurchase(enhancement) else {
            return
        }
        let level = companyStore.level(enhancement: enhancement) + 1
        let cost = enhancement.cost(level: level)
        
        try! inventory.consume(inputs: cost)
        companyStore.company.enhancements[enhancement] = level
    }
    
    func cost(_ enhancement: Enhancement) -> [ItemCount] {
        let level = companyStore.level(enhancement: enhancement) + 1
        return enhancement.cost(level: level)
    }
    
    func canPurchase(_ enhancement: Enhancement) -> Bool {
        let level = companyStore.level(enhancement: enhancement)
        if level >= enhancement.maxLevel {
            return false
        }
        let cost = enhancement.cost(level: level + 1)
        return inventory.containsAll(items: cost)
    }
    
}
