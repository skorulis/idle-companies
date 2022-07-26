//  Created by Alexander Skorulis on 25/7/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct MetallurgyView {
    
    @StateObject var viewModel: MetallurgyViewModel
    @Environment(\.factory) private var factory
}

// MARK: - Rendering

extension MetallurgyView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: Text("Metallurgy")
                        .foregroundColor(.label)
                        .font(.headline)
        )
    }
    
    private func content() -> some View {
        VStack {
            ForEach(viewModel.options) { dest in
                navButton(dest)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func navButton(_ dest: OperationPath) -> some View {
        Button(action: viewModel.show(dest)) {
            Text("Smelting")
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
    
}

// MARK: - Previews

struct MetallurgyView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MetallurgyView(viewModel: ioc.resolve())
    }
}

