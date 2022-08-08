//  Created by Alexander Skorulis on 8/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ManageEnhancementsView {
    @StateObject var viewModel: ManageEnhancementsViewModel
}

// MARK: - Rendering

extension ManageEnhancementsView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Enhancements"))
    }
    
    private func content() -> some View {
        VStack {
            
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Previews

struct ManageEnhancementsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ManageEnhancementsView(viewModel: ioc.resolve())
    }
}

