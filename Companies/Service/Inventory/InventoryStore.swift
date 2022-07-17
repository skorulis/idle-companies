//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

final class InventoryStore: ObservableObject {
    
    @Published private(set) var inventory: [ItemType: Int] = [:]
    
}

// MARK: - Logic

extension InventoryStore {
    
    func add(item: ItemType, count: Int) {
        inventory[item] = self.count(item: item) + count
        print(inventory)
    }
    
    func count(item: ItemType) -> Int {
        return inventory[item] ?? 0
    }
}
