//  Created by Alexander Skorulis on 25/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemDetailsView {
    
    let item: ItemType
    @ObservedObject var inv: InventoryStore
    @Environment(\.presentationMode) private var presentationMode
}

// MARK: - Rendering

extension ItemDetailsView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: EmptyView(),
               mid: BarButtonItem.title("Details"),
               right: closeButton)
    }
    
    private func content() -> some View {
        VStack {
            RecipeOutputView(item: item, inv: inv)
        }
        .padding(.horizontal, 16)
    }
    
    private var closeButton: some View {
        Button(action: dismiss) {
            Image(systemName: "xmark.circle.fill")
        }
    }
        
        
}

// MARK: - Logic

private extension ItemDetailsView {
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: - Previews

struct ItemDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ItemDetailsView(item: .stone, inv: ioc.resolve())
    }
}

