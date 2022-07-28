//  Created by Alexander Skorulis on 28/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct HQUpgradeView {
    @StateObject var viewModel: HQUpgradeViewModel
}

// MARK: - Rendering

extension HQUpgradeView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: maybeContent)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Upgrade HQ"))
    }
    
    @ViewBuilder
    private func maybeContent() -> some View {
        if let type = viewModel.type {
            content(type: type)
        }
    }
    
    private func content(type: HQType) -> some View {
        VStack {
            IngredientsView(ingredients: type.requirements, inventory: viewModel.inventory)
                .panelBackground()
            
            Button(action: viewModel.upgrade) {
                Text("Upgrade")
            }
            .panelBackground()
            .disabled(!viewModel.canUpgrade)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

struct HQUpgradeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        HQUpgradeView(viewModel: ioc.resolve())
    }
}

