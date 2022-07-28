//  Created by Alexander Skorulis on 27/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionContractsView {
    @StateObject var viewModel: ConstructionContractsViewModel
}

// MARK: - Rendering

extension ConstructionContractsView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Contracts"))
    }
    
    private func content() -> some View {
        VStack {
            ForEach(viewModel.options) { activity in
                Button(action: viewModel.start(activity)) {
                    ConstructionContractActivityView(activity: activity, progress: viewModel.maybeProgress(activity))
                        .contentShape(Rectangle())
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

struct ConstructionContractsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ConstructionContractsView(viewModel: ioc.resolve())
    }
}

