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
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Upgrade HQ"))
    }
    
    private func content() -> some View {
        VStack {
            
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

