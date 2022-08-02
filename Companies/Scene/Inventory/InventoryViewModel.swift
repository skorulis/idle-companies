//  Created by Alexander Skorulis on 17/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class InventoryViewModel: ObservableObject {
    
    let inventoryStore: InventoryStore
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var selectedItem: ItemType?
    
    init(inventoryStore: InventoryStore) {
        self.inventoryStore = inventoryStore
        self.inventoryStore.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension InventoryViewModel {
    
    var inventory: [ItemCount] {
        return inventoryStore.inventory.map { (item, value) in
            return ItemCount(type: item, count: value)
        }.filter { $0.type != .credits }
    }
    
}

// MARK: - Logic

extension InventoryViewModel {
    
    func onClick(_ item: ItemCount) -> () -> Void {
        return { [unowned self] in
            self.selectedItem = item.type
        }
    }
}
