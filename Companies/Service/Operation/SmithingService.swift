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
    
    func duration(_ recipe: SmithingActivity) -> TimeInterval {
        return recipe.baseTime
    }
    
    func start(_ recipe: SmithingActivity) throws {
        try recipeService.consume(inputs: recipe.inputs)
    }
    
    func onFinish(_ recipe: SmithingActivity) {
        let output = ItemCount(type: recipe.output, count: 1)
        recipeService.finish(outputs: [output])
    }
    
}
