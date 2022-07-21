//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

// MARK: - Memory footprint

struct SmithingService {
    
    private let recipeService: RecipeService
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
}

// MARK: - Logic

extension SmithingService {
    
    func duration(_ recipe: ItemRecipeOperation) -> TimeInterval {
        return recipe.baseTime
    }
    
    func start(_ recipe: ItemRecipeOperation) throws {
        try recipeService.consume(recipe: recipe.recipe)
    }
    
    func onFinish(_ recipe: ItemRecipeOperation) {
        recipeService.finish(recipe: recipe.recipe)
    }
    
}

// MARK: - Computed values

extension SmithingService {
 
    var recipes: [ItemRecipeOperation] {
        return [
            Self.brickRecipe,
            Self.concreteRecipe,
            Self.ironBarRecipe,
            Self.goldBarRecipe
        ]
    }
    
    static var brickRecipe: ItemRecipeOperation {
        let ing = ItemRecipe(inputs: [.init(type: .stone, count: 1)], output: .brick)
        return .init(recipe: ing, baseTime: 3)
    }
    
    static var concreteRecipe: ItemRecipeOperation {
        let ing = ItemRecipe(inputs: [.init(type: .stone, count: 2), .init(type: .limestone, count: 1)], output: .concrete)
        return .init(recipe: ing, baseTime: 10)
    }
    
    static var ironBarRecipe: ItemRecipeOperation {
        let ing = ItemRecipe(inputs: [.init(type: .ironOre, count: 1)], output: .ironBar)
        return .init(recipe: ing, baseTime: 5)
    }
    
    static var goldBarRecipe: ItemRecipeOperation {
        let ing = ItemRecipe(inputs: [.init(type: .goldOre, count: 2)], output: .goldBar)
        return .init(recipe: ing, baseTime: 10)
    }
    
}
