//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MineTypeView {
    
    let type: MiningType
}

// MARK: - Rendering

extension MineTypeView: View {
    
    var body: some View {
        VStack {
            Text("Mine")
            Text(type.name)
            DurationView(time: type.baseTime)
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(Color.black.opacity(0.1))
        )
    }
}

// MARK: - Previews

struct MineTypeView_Previews: PreviewProvider {
    
    static var previews: some View {
        MineTypeView(type: .gold)
    }
}

