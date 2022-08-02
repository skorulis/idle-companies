//  Created by Alexander Skorulis on 2/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct RecipeCreateView<T: POperation> {
    
    private let activity: T
    private let progress: OperationProgress?
    private let onStart: () -> Void
    
    init(activity: T,
         progress: OperationProgress?,
         onStart: @escaping () -> Void
    ) {
        self.activity = activity
        self.progress = progress
        self.onStart = onStart
    }
}

// MARK: - Rendering

extension RecipeCreateView: View {
    
    var body: some View {
        VStack {
            stats
            Button(action: onStart) {
                Text("Start")
            }
            
            OperationProgressView(timing: progress?.timing)
        }
        .panelBackground()
    }
    
    private var stats: some View {
        HStack {
            DurationView(time: activity.baseTime)
            ExperienceView(xp: activity.baseXP)
        }
    }
}

// MARK: - Previews

struct RecipeCreateView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeCreateView(activity: MiningActivity.rock,
                         progress: nil,
                         onStart: {})
    }
}

