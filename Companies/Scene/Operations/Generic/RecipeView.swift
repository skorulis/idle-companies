//  Created by Alexander Skorulis on 20/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct RecipeView {
    let recipe: ItemRecipe
}

// MARK: - Rendering

extension RecipeView: View {
    
    var body: some View {
        HStack {
            icon
            Text(recipe.name)
            Spacer()
        }
    }
    
    private var icon: some View {
        recipe.outputs[0].type.icon
            .image(20)
    }
}

// MARK: - Previews

struct RecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeView(recipe: SmithingService.ironBarRecipe.recipe)
    }
}

