//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

final class InventoryStore: ObservableObject {
    
    @Published private(set) var inventory: [ItemType: Int] {
        didSet {
            writeToDisk()
        }
    }
    private let store: PKeyValueStore
    private static let storageKey = "InventoryStore.storageKey"
    
    init(store: PKeyValueStore) {
        self.store = store
        let data = Self.readFromDisk(store: store)
        inventory = data.items
    }
    
}

// MARK: - Logic

extension InventoryStore {
    
    func add(item: ItemType, count: Int) {
        inventory[item] = self.count(item: item) + count
    }
    
    func count(item: ItemType) -> Int {
        return inventory[item] ?? 0
    }
    
    func contains(item: ItemCount) -> Bool {
        return count(item: item.type) >= item.count
    }
    
    func containsAll(items: [ItemCount]) -> Bool {
        for item in items {
            if !contains(item: item) {
                return false
            }
        }
        return true
    }
    
    func remove(item: ItemCount) {
        let finalCount = count(item: item.type) - item.count
        assert(finalCount >= 0, "Attempt to steal items")
        if finalCount == 0 {
            inventory.removeValue(forKey: item.type)
        } else {
            inventory[item.type] = finalCount
        }
    }
    
    func removeAll(items: [ItemCount]) {
        items.forEach { remove(item: $0) }
    }
}

// MARK: - Inner types

private extension InventoryStore {
    struct DiskStorage: Codable {
        let items: [ItemType: Int]
    }
}

// MARK: - Private logic

private extension InventoryStore {
    
    func writeToDisk() {
        let storage = DiskStorage(items: inventory)
        try! store.set(codable: storage, forKey: Self.storageKey)
    }
    
    static func readFromDisk(store: PKeyValueStore) -> DiskStorage {
        if let item: DiskStorage = try? store.codable(forKey: Self.storageKey) {
            return item
        }
        return DiskStorage(items: [:])
    }
    
}
