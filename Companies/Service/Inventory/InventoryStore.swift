//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

final class InventoryStore: ObservableObject {
    
    @Published private(set) var inventory: [ItemType: Int] {
        didSet {
            try! self.store.set(codable: inventory, forKey: Self.storageKey)
        }
    }
    
    @Published private(set) var battalions: [Int: Battalion] {
        didSet {
            try! self.store.set(codable: battalions, forKey: Self.battalionsKey)
        }
    }
    
    private let store: PKeyValueStore
    private let toasts: ToastPresentationService
    private static let storageKey = "InventoryStore.storageKey"
    private static let battalionsKey = "InventoryStore.battalions"
    private let changeService: ChangeHistoryService
    private let transientValues: TransientValuesStore
    
    init(store: PKeyValueStore,
         toasts: ToastPresentationService,
         changeService: ChangeHistoryService,
         transientValues: TransientValuesStore
    ) {
        self.store = store
        self.toasts = toasts
        self.changeService = changeService
        self.transientValues = transientValues
        self.inventory = Self.readFromDisk(store: store)
        self.battalions = Self.readBattalions(store: store)
    }
    
}

// MARK: - Logic

extension InventoryStore {
    
    var itemCount: Int {
        let offset = inventory[.credits] != nil ? -1 : 0
        return inventory.count + offset
    }
    
    func add(item: ItemType, count: Int) throws {
        if itemCount == transientValues.inventorySize && inventory[item] == nil && item != .credits {
            toasts.add(text: "Your inventory is full", style: .negative)
            throw ErrorType.full
        }
        inventory[item] = self.count(item: item) + count
        toasts.add(text: "+\(count) \(item.name)", style: .positive)
        changeService.change(item: item, count: count)
    }
    
    func addAll(items: [ItemCount]) throws {
        var filledError: Error?
        for item in items {
            do {
                try add(item: item)
            } catch {
                filledError = error
            }
        }
        // Try to add all the items and throw if any couldn't be added
        if let error = filledError {
            throw error
        }
    }
    
    func add(item: ItemCount) throws {
        try add(item: item.type, count: item.count)
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
    
    func sell(item: ItemCount) {
        remove(item: item)
        let credits = item.count * item.type.creditValue
        try! add(item: .credits, count: credits)
    }
    
    var credits: Int {
        return inventory[.credits] ?? 0
    }
    
    func updateBatallion(index: Int, battalion: Battalion) {
        toasts.add(text: "+1 Soldier", style: .positive)
        self.battalions[index] = battalion
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
    
    static func readBattalions(store: PKeyValueStore) -> [Int: Battalion] {
        if let inventory: [Int: Battalion] = try? store.codable(forKey: Self.battalionsKey) {
            return inventory
        }
        return [:]
    }
    
}

// MARK: - Inner types

extension InventoryStore {
    
    enum ErrorType: Error, LocalizedError {
        case full
        
        var errorDescription: String? {
            switch self {
            case .full:
                return "Your inventory is full"
            }
        }
    }
}
