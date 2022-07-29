//  Created by Alexander Skorulis on 29/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionMaterialsView {
    @StateObject var viewModel: ConstructionMaterialsViewModel
}

// MARK: - Rendering

extension ConstructionMaterialsView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Materials"))
    }
    
    private func content() -> some View {
        VStack {
            ForEach(ConstructionMaterialActivity.allCases) { activity in
                ConstructionMaterialActivtyView(activity: activity, progress: nil, inv: viewModel.inventory)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

struct ConstructionMaterialsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ConstructionMaterialsView(viewModel: ioc.resolve())
    }
}

