//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

// MARK: - Memory footprint

struct MiningService {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
    }
    
    func onFinish(_ place: ItemRecipeOperation) {
        let item = RecipeService.randomItem(recipe: place.recipe)
        inventory.add(item: item, count: 1)
    }
    
    func duration(_ type: ItemRecipeOperation) -> TimeInterval {
        return type.baseTime
    }
    
}

// MARK: - Computed values

extension MiningService {
    
    var locations: [ItemRecipeOperation] {
        return [
            Self.beachQuarry,
            Self.rockQuarry,
            Self.ironMine
        ]
    }
    
    static var beachQuarry: ItemRecipeOperation {
        let outputs: [ItemCount] = [
            .init(type: .limestone, count: 2),
            .init(type: .stone, count: 1)
        ]
        let ing = ItemRecipe(name: "Beach quarry", inputs: [], outputs: outputs)
        return .init(recipe: ing, baseTime: 5)
    }
    
    static var rockQuarry: ItemRecipeOperation {
        let outputs: [ItemCount] = [
            .init(type: .stone, count: 2),
            .init(type: .coal, count: 1)
        ]
        let ing = ItemRecipe(name: "Rock quarry", inputs: [], outputs: outputs)
        return .init(recipe: ing, baseTime: 5)
    }
    
    static var ironMine: ItemRecipeOperation {
        let outputs: [ItemCount] = [
            .init(type: .ironOre, count: 5),
            .init(type: .stone, count: 2),
            .init(type: .coal, count: 1)
        ]
        let ing = ItemRecipe(name: "Iron mine", inputs: [], outputs: outputs)
        return .init(recipe: ing, baseTime: 7)
    }
}
