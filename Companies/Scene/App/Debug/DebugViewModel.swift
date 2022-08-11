//  Created by Alexander Skorulis on 21/7/2022.

#if DEBUG

import Foundation

// MARK: - Memory footprint

final class DebugViewModel: ObservableObject {
 
    private let timeProvider: DebugTimeProvider
    private let inventory: InventoryStore
    
    @Published var speed: TimeInterval {
        didSet {
            timeProvider.speed = speed
        }
    }
    
    init(timeProvider: PTimeProvider,
         inventory: InventoryStore
    ) {
        self.timeProvider = timeProvider as! DebugTimeProvider
        self.inventory = inventory
        _speed = Published(wrappedValue: self.timeProvider.speed)
    }
    
}

// MARK: - Computed values

extension DebugViewModel {
 
    
}

// MARK: - Logic

extension DebugViewModel {
    
    func clearInventory() {
        let items = inventory.inventory
        for (key, value) in items {
            inventory.remove(item: ItemCount(type: key, count: value))
        }
    }
    
    func addItems(_ count: Int) {
        let items = inventory.inventory
        for (key, _) in items {
            try? inventory.add(item: ItemCount(type: key, count: count))
        }
    }
    
}

#endif
