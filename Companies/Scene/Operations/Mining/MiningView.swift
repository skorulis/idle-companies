//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct MiningView {
    
    @StateObject var viewModel: MiningViewModel
    @Environment(\.as_presentation) private var presentation
}

// MARK: - Rendering

extension MiningView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            NavBar(left: BarButtonItem.back(back), mid: Text("Mining"))
            content
        }
        .navigationBarHidden(true)
    }
    
    private var content: some View {
        ScrollView {
            VStack {
                SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
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

// MARK: - Logic

private extension MiningView {
    func back() {
        presentation.dismiss()
    }
}

// MARK: - Previews

struct MiningView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MiningView(viewModel: ioc.resolve())
    }
}

