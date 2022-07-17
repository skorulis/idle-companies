//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct DurationView {
    
    let time: TimeInterval
}

// MARK: - Rendering

extension DurationView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "clock.arrow.circlepath")
            Text("\(time, specifier: "%.1f")s")
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.1))
        )
    }
}

// MARK: - Previews

struct DurationView_Previews: PreviewProvider {
    
    static var previews: some View {
        DurationView(time: 10)
    }
}

