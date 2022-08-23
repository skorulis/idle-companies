//  Created by Alexander Skorulis on 12/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MilitaryTrainingView {
    @StateObject var viewModel: MilitaryTrainingViewModel
}

// MARK: - Rendering

extension MilitaryTrainingView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Training"))
    }
    
    private func content() -> some View {
        VStack {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            Text("Battalions")
            BattalionList(inventory: viewModel.inventory, selectedIndex: $viewModel.selectedIndex)
            OperationProgressView(timing: viewModel.maybeProgress?.timing)
            startButton
        }
        .padding(.horizontal, 16)
    }
    
    private var startButton: some View {
        Button(action: viewModel.start) {
            Text("Start")
        }
    }
}

// MARK: - Previews

struct MilitaryTrainingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let coordinator = ioc.emptyCoordinator
        MilitaryTrainingView(viewModel: coordinator.resolve())
    }
}

