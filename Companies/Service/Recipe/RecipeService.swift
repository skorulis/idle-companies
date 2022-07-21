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
    
    func consume(recipe: ItemRecipe) throws {
        if !inventory.containsAll(items: recipe.inputs) {
            throw RecipeError.missingIngredients
        }
        inventory.removeAll(items: recipe.inputs)
    }
    
    func finish(recipe: ItemRecipe) {
        for item in recipe.outputs {
            inventory.add(item: item.type, count: item.count)
        }
    }
    
    static func randomItem(recipe: ItemRecipe) -> ItemType {
        let count = recipe.outputCount
        let choice = Int.random(in: 1...count)
        var value: Int = 0
        for item in recipe.outputs {
            value += item.count
            if value >= choice {
                return item.type
            }
        }
        fatalError("Rolled \(choice) for \(recipe.outputs)")
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
