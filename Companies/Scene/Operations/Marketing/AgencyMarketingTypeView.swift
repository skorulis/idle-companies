//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct AgencyMarketingTypeView {
    
    let type: MarketingType
    let progress: OperationProgress?
}

// MARK: - Rendering

extension AgencyMarketingTypeView: View {
    
    var body: some View {
        VStack {
            Text("Market")
            Text(type.name)
            DurationView(time: type.baseTime)
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

struct AgencyMarketingTypeView_Previews: PreviewProvider {
    
    /*private static var progress: OperationProgress {
        return .init(operation: .agencyMarketing(.radio),
                     timing: .init(startTime: Date(), duration: 5),
                     lastTick: Date()
        )
    }*/
    
    static var previews: some View {
        VStack {
            //AgencyMarketingTypeView(type: .internet, progress: nil)
            
            //AgencyMarketingTypeView(type: .radio, progress: progress)
        }
    }
}


