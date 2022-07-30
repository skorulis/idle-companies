//  Created by Alexander Skorulis on 22/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ActivityStatsView<Act: POperation> {
    
    let activity: Act
    
}

// MARK: - Rendering

extension ActivityStatsView: View {
    
    var body: some View {
        HStack {
            DurationView(time: activity.baseTime)
            ExperienceView(xp: activity.baseXP)
        }
    }
}

// MARK: - Previews

struct ActivityStatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityStatsView(activity: MiningActivity.beach)
    }
}

