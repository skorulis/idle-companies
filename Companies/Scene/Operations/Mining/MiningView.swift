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
        content
            .navigationTitle("Mining")
    }
    
    private var content: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.availableMining) { place in
                    Button(action: viewModel.onPress(place)) {
                        MiningPlaceView(operation: place,
                                        progress: viewModel.maybeProgress(place))
                        .contentShape(Rectangle())
                    }

                    
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Previews

struct MiningView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MiningView(viewModel: ioc.resolve())
    }
}

