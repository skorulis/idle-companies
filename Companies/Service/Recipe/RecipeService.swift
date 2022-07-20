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
