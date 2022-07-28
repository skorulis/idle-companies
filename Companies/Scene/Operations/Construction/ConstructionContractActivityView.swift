//  Created by Alexander Skorulis on 27/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionContractActivityView {
    let activity: ConstructionContractActivity
    let progress: OperationProgress?
}

// MARK: - Rendering

extension ConstructionContractActivityView: View {
    
    var body: some View {
        VStack {
            Text(activity.name)
            DurationView(time: activity.baseTime)
            maybeProgress
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
    
    @ViewBuilder
    private var maybeProgress: some View {
        OperationProgressView(timing: progress?.timing)
    }
}

// MARK: - Previews

struct ConstructionContractActivityView_Previews: PreviewProvider {
    
    static var previews: some View {
        ConstructionContractActivityView(activity: .carpentry, progress: nil)
    }
}

