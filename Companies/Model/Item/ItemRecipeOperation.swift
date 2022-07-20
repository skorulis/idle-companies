//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

public struct ItemRecipeOperation {
    public let recipe: ItemRecipe
    public let baseTime: TimeInterval
}

extension ItemRecipeOperation: Identifiable {
    
    public var id: String { recipe.id }
}
