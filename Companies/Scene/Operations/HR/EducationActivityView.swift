//
//  EducationActivityView.swift
//  Companies
//
//  Created by Alexander Skorulis on 6/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct EducationActivityView {
    
    private let activity: EducationActivity
    private let progress: OperationProgress?
    private let onStart: () -> Void
    @ObservedObject private var inv: InventoryStore
    
    init(activity: EducationActivity,
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

extension EducationActivityView: View {
    
    var body: some View {
        VStack(spacing: 4) {
            RecipeOutputView(item: activity.outputStack.type, inv: inv)
            IngredientsView(ingredients: activity.inputs, inventory: inv)
                .panelBackground()
            
            RecipeCreateView(activity: activity,
                             progress: progress,
                             onStart: onStart)
        }
    }

}

struct EducationActivityView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let inv = ioc.resolve(InventoryStore.self)
        ScrollView {
            VStack {
                EducationActivityView(activity: .teaching, progress: nil, inv: inv, onStart: {})
            }
            .padding(.horizontal, 16)
        }
    }
    
}
