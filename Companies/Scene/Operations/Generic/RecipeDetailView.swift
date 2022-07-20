//  Created by Alexander Skorulis on 20/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct RecipeDetailView {
    let recipe: ItemRecipeOperation
    let inv: InventoryStore
}

// MARK: - Rendering

extension RecipeDetailView: View {
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Requires:")
            inputs
            Text("You have:")
            counts
        }
    }
    
    var inputs: some View {
        HStack {
            ForEach(recipe.recipe.inputs) { item in
                ItemCountView(item: item)
            }
        }
    }
    
    var counts: some View {
        HStack {
            ForEach(inputCounts) { item in
                ItemCountView(item: item)
            }
        }
    }
    
}

// MARK: - Computed values

extension RecipeDetailView {
    
    var inputCounts: [ItemCount] {
        return recipe.recipe.inputs.map { item in
            return ItemCount(type: item.type, count: inv.count(item: item.type))
        }
    }
    
}

// MARK: - Previews

struct RecipeDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let inv = ioc.resolve(InventoryStore.self)
        return RecipeDetailView(recipe: SmithingService.goldBarRecipe, inv: inv)
    }
}

