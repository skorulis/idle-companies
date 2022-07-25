//  Created by Alexander Skorulis on 22/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct PercentageOutputView {
    let options: [ItemPercentage]
}

// MARK: - Rendering

extension PercentageOutputView: View {
    
    var body: some View {
        HStack {
            ForEach(options) { item in
                ItemPercentageView(item: item)
            }
        }
    }
}

// MARK: - Previews

struct PercentageOutputView_Previews: PreviewProvider {
    
    static var previews: some View {
        PercentageOutputView(options: MiningActivity.iron.outputPercentages)
    }
}

