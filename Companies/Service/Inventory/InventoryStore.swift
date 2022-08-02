//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

final class InventoryStore: ObservableObject {
    
    @Published private(set) var inventory: [ItemType: Int] {
        didSet {
            try! self.store.set(codable: inventory, forKey: Self.storageKey)
        }
    }
    private let store: PKeyValueStore
    private let toasts: ToastPresentationService
    private static let storageKey = "InventoryStore.storageKey"
    private let changeService: ChangeHistoryService
    
    init(store: PKeyValueStore,
         toasts: ToastPresentationService,
         changeService: ChangeHistoryService
    ) {
        self.store = store
        self.toasts = toasts
        self.changeService = changeService
        self.inventory = Self.readFromDisk(store: store)
    }
    
}

// MARK: - Logic

extension InventoryStore {
    
    func add(item: ItemType, count: Int) {
        inventory[item] = self.count(item: item) + count
        toasts.add(text: "+\(count) \(item.name)", style: .positive)
        changeService.change(item: item, count: count)
    }
    
    func add(item: ItemCount) {
        add(item: item.type, count: item.count)
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
        toasts.add(text: "-\(item.count) \(item.type.name)", style: .negative)
        changeService.change(item: item.type, count: item.count * -1)
    }
    
    func removeAll(items: [ItemCount]) {
        items.forEach { remove(item: $0) }
    }
    
    func consume(inputs: [ItemCount]) throws {
        if !containsAll(items: inputs) {
            throw RecipeError.missingIngredients
        }
        removeAll(items: inputs)
    }
}

// MARK: - Logic (private)

private extension InventoryStore {
    
    static func readFromDisk(store: PKeyValueStore) -> [ItemType: Int] {
        if let inventory: [ItemType: Int] = try? store.codable(forKey: Self.storageKey) {
            return inventory
        }
        return [:]
    }
    
}
