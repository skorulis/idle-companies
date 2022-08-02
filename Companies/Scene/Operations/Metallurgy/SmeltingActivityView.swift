//  Created by Alexander Skorulis on 22/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SmeltingActivityView {
    let activity: SmeltingActivity
    let progress: OperationProgress?
    let inv: InventoryStore
    let onStart: () -> Void
    
}

// MARK: - Rendering

extension SmeltingActivityView: View {
    
    var body: some View {
        VStack(spacing: 4) {
            RecipeOutputView(item: activity.output, inv: inv)
            IngredientsView(ingredients: activity.inputs, inventory: inv)
                .panelBackground()
            
            RecipeCreateView(activity: activity,
                             progress: progress,
                             onStart: onStart)
        }
    }
}

// MARK: - Previews

struct SmithingRecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        SmeltingActivityView(activity: SmeltingActivity.goldBar,
                             progress: nil,
                             inv: ioc.resolve(),
                             onStart: {}
        )
    }
}

