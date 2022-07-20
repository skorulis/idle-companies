//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

struct SmithingService {
    
    private let recipeService: RecipeService
    
    init(recipeService: RecipeService) {
        self.recipeService = recipeService
    }
    
}
