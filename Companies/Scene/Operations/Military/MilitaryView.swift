//  Created by Alexander Skorulis on 12/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MilitaryView {
    
    @StateObject var viewModel: MilitaryViewModel
}

// MARK: - Rendering

extension MilitaryView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Military")
        )
    }
    
    private func content() -> some View {
        VStack {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            Text("Battalions")
            BattalionList(inventory: viewModel.inventory)
            ForEach(MilitarySubType.allCases) { type in
                BasicMenuButton(item: type, action: viewModel.show(type))
            }
        }
        .padding(.horizontal, 16)
    }
    
}

// MARK: - Previews

struct MilitaryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let coordinator = ioc.emptyCoordinator
        MilitaryView(viewModel: coordinator.resolve())
    }
}

