//  Created by Alexander Skorulis on 6/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct HumanResourcesView {
    @StateObject var viewModel: HumanResourcesViewModel
}

// MARK: - Rendering

extension HumanResourcesView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
            
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Human resources"))
    }
    
    private func content() -> some View {
        VStack(spacing: 8) {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            ForEach(HRSubType.allCases) { type in
                button(type: type)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func button(type: HRSubType) -> some View {
        Button(action: viewModel.show(type)) {
            HStack {
                type.icon.image(24)
                Text(type.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Previews

struct HumanResourcesView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        HumanResourcesView(viewModel: ioc.resolve())
    }
}

