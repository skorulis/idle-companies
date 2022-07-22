//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

// MARK: - Memory footprint

struct RecipeService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
}

// MARK: - Logic

extension RecipeService {
    
    func consume(inputs: [ItemCount]) throws {
        if !inventory.containsAll(items: inputs) {
            throw RecipeError.missingIngredients
        }
        inventory.removeAll(items: inputs)
    }
    
    func finish(outputs: [ItemCount]) {
        for item in outputs {
            inventory.add(item: item.type, count: item.count)
        }
    }
    
    static func randomItem(percentages: [ItemPercentage]) -> ItemType {
        let choice = Double.random(in: 0...1)
        var value: Double = 0
        for item in percentages {
            value += item.percent
            if value >= choice {
                return item.type
            }
        }
        fatalError("Rolled \(choice) for \(percentages)")
    }
    
}

// MARK: - Inner type

extension RecipeService {
    
    enum RecipeError: Error, LocalizedError {
        
        case missingIngredients
        
        var errorDescription: String? {
            switch self {
            case .missingIngredients:
                return "Insufficient ingredients"
            }
        }
    }
}
