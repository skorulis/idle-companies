//  Created by Alexander Skorulis on 29/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ConstructionMaterialsView {
    @StateObject var viewModel: ConstructionMaterialsViewModel
    @State private var scrollViewID = UUID()
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
            maybeCurrent
            
            ForEach(ConstructionMaterialActivity.allCases) { activity in
                Button(action: select(activity)) {
                    SimpleRecipeView(output: activity.output)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var maybeCurrent: some View {
        if let activity = viewModel.selected {
            ConstructionMaterialActivtyView(activity: activity,
                                            progress: viewModel.maybeProgress,
                                            inv: viewModel.inventory,
                                            onStart: viewModel.start)
        }
    }
}

// MARK: - Logic

private extension ConstructionMaterialsView {
    
    func select(_ activity: ConstructionMaterialActivity) -> () -> Void {
        return {
            self.viewModel.select(activity)
        }
    }
}

// MARK: - Previews

struct ConstructionMaterialsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ConstructionMaterialsView(viewModel: ioc.resolve())
    }
}

