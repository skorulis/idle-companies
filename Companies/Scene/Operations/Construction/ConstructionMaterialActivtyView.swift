//  Created by Alexander Skorulis on 29/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionMaterialActivtyView {
    
    private let activity: ConstructionMaterialActivity
    private let progress: OperationProgress?
    private let onStart: () -> Void
    @ObservedObject private var inv: InventoryStore
    
    init(activity: ConstructionMaterialActivity,
         progress: OperationProgress?,
         inv: InventoryStore,
         onStart: @escaping () -> Void
    ) {
        self.activity = activity
        self.progress = progress
        self.onStart = onStart
        _inv = ObservedObject(wrappedValue: inv)
    }
}

// MARK: - Rendering

extension ConstructionMaterialActivtyView: View {
    
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

struct ConstructionMaterialActivtyView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let inv = ioc.resolve(InventoryStore.self)
        ScrollView {
            VStack {
                ConstructionMaterialActivtyView(activity: .concrete, progress: nil, inv: inv, onStart: {})
            }
            .padding(.horizontal, 16)
        }
    }
    
}
