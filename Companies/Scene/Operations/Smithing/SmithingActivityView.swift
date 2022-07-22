//  Created by Alexander Skorulis on 22/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SmithingActivityView {
    let activity: SmithingActivity
    let progress: OperationProgress?
}

// MARK: - Rendering

extension SmithingActivityView: View {
    
    var body: some View {
        VStack {
            Text(activity.name)
            ActivityStatsView(activity: activity)
            OperationProgressView(timing: progress?.timing)
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(backgroundColor)
        )
    }
    
    private var backgroundColor: Color {
        if progress != nil {
            return Color.green.opacity(0.1)
        } else {
            return Color.black.opacity(0.1)
        }
    }
}

// MARK: - Previews

struct SmithingRecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        SmithingActivityView(activity: SmithingActivity.goldBar, progress: nil)
    }
}

