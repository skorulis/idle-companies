//  Created by Alexander Skorulis on 6/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct EducationView {
    @StateObject var viewModel: EducationViewModel
}

// MARK: - Rendering

extension EducationView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Education"))
    }
    
    private func content() -> some View {
        VStack {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            current
            
            ForEach(EducationActivity.allCases) { activity in
                Button(action: select(activity)) {
                    SimpleRecipeView(output: activity.outputStack.type)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var current: some View {
        EducationActivityView(activity: viewModel.selected,
                                        progress: viewModel.maybeProgress,
                                        inv: viewModel.inventory,
                                        onStart: viewModel.start)
    }
}

// MARK: - Logic

private extension EducationView {
    
    func select(_ activity: EducationActivity) -> () -> Void {
        return {
            self.viewModel.select(activity)
        }
    }
}

// MARK: - Previews

struct EducationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        EducationView(viewModel: ioc.resolve())
    }
}

