//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct MiningView {
    
    @StateObject var viewModel: MiningViewModel
}

// MARK: - Rendering

extension MiningView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            navBar
            content
        }
        .navigationBarHidden(true)
    }
    
    private var navBar: some View {
        NavBar(
            left: BarButtonItem.back(),
            mid: Text("Mining")
                    .foregroundColor(.label)
                    .font(.headline)
        )
    }
    
    private var content: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 20)
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
        .background(Color.background2)
    }
}

// MARK: - Previews

struct MiningView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MiningView(viewModel: ioc.resolve())
    }
}

