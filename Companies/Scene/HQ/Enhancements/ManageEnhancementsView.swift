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
            list
        }
        .padding(.horizontal, 16)
    }
    
    private var list: some View {
        ForEach(viewModel.available) { enhancement in
            listItem(enhancement)
        }
    }
    
    private func listItem(_ enhancement: Enhancement) -> some View {
        VStack {
            HStack {
                Text(enhancement.name)
                Spacer()
                Text(viewModel.levelsString(enhancement))
            }
            Button(action: { viewModel.purchase(enhancement) }) {
                Text("Buy")
            }
        }
    }
}

// MARK: - Previews

struct ManageEnhancementsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ManageEnhancementsView(viewModel: ioc.resolve())
    }
}

