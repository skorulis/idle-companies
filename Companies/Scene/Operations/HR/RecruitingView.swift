//  Created by Alexander Skorulis on 6/8/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct RecruitingView {
    
    @StateObject var viewModel: RecruitingViewModel
}

// MARK: - Rendering

extension RecruitingView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
            
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Recruiting"))
    }
    
    private func content() -> some View {
        VStack(spacing: 8) {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

struct RecruitingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        RecruitingView(viewModel: ioc.resolve())
    }
}

