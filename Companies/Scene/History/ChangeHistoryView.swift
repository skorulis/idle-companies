//  Created by Alexander Skorulis on 1/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ChangeHistoryView {
    
    @StateObject var viewModel: ChangeHistoryViewModel
}

// MARK: - Rendering

extension ChangeHistoryView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: EmptyView(),
               mid: EmptyView(),
               right: closeButton)
    }
    
    private var closeButton: some View {
        Button(action: {}) {
            Image(systemName: "xmark.circle.fill")
        }
    }
    
    private func content() -> some View {
        VStack {
            Text("While you were away")
            ForEach(viewModel.itemList) { item in
                Text("\(item.count) \(item.type.name)")
            }
        }
    }
}

// MARK: - Logic

private extension ChangeHistoryView {
    
}

// MARK: - Previews

struct ChangeHistoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ChangeHistoryView(viewModel: ioc.resolve())
    }
}

