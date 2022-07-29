//  Created by Alexander Skorulis on 29/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionMaterialActivtyView {
    
    private let activity: ConstructionMaterialActivity
    private let progress: OperationProgress?
    @ObservedObject private var inv: InventoryStore
    
    init(activity: ConstructionMaterialActivity,
         progress: OperationProgress?,
         inv: InventoryStore
    ) {
        self.activity = activity
        self.progress = progress
        _inv = ObservedObject(wrappedValue: inv)
    }
}

// MARK: - Rendering

extension ConstructionMaterialActivtyView: View {
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                outputCountView
                rightTop
            }
            IngredientsView(ingredients: activity.inputs, inventory: inv)
                .panelBackground()
        }
    }
    
    private var rightTop: some View {
        VStack(alignment: .leading) {
            Text("Create")
            Spacer()
                .layoutPriority(-1)
            Text(activity.output.name)
        }
        .panelBackground()
    }
    
    private var outputCountView: some View {
        VStack {
            ItemIconView(item: activity.output)
            Text("\(outputCount)")
        }
        .padding(4)
        .background(PanelBackground())
    }
}

// MARK: - Computed values

private extension ConstructionMaterialActivtyView {
    
    var outputCount: Int {
        inv.count(item: activity.output)
    }
    
    
}

struct ConstructionMaterialActivtyView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let inv = ioc.resolve(InventoryStore.self)
        ScrollView {
            VStack {
                ConstructionMaterialActivtyView(activity: .concrete, progress: nil, inv: inv)
            }
            .padding(.horizontal, 16)
        }
    }
    
}
