//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MiningView {
    
    @StateObject var viewModel: MiningViewModel
}

// MARK: - Rendering

extension MiningView: View {
    
    var body: some View {
        VStack {
            ForEach(viewModel.availableMining) { type in
                Button(action: viewModel.onPress(type)) {
                    MineTypeView(type: type,
                                 progress: viewModel.maybeProgress(type)
                    )
                    .contentShape(Rectangle())
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

struct MiningView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MiningView(viewModel: ioc.resolve())
    }
}

