//  Created by Alexander Skorulis on 27/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionView {
    
    @StateObject var viewModel: ConstructionViewModel
}

// MARK: - Rendering

extension ConstructionView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
            
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Construction"))
    }
    
    private func content() -> some View {
        VStack(spacing: 8) {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            ForEach(ConstructionSubType.allCases) { type in
                button(type: type)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func button(type: ConstructionSubType) -> some View {
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

struct ConstructionView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ConstructionView(viewModel: ioc.resolve())
    }
}

