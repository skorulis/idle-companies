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
            maybeSellSection
        }
        .padding(.horizontal, 16)
    }
    
    private var closeButton: some View {
        Button(action: dismiss) {
            Image(systemName: "xmark.circle.fill")
        }
    }
    
    @ViewBuilder
    private var maybeSellSection: some View {
        if count > 0 {
            Button(action: sell) {
                Text("Sell")
            }
        }
    }

}

// MARK: - Computed values

private extension ItemDetailsView {
 
    var count: Int {
        return inv.count(item: item)
    }
}

// MARK: - Logic

private extension ItemDetailsView {
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func sell() {
        inv.sell(item: ItemCount(type: item, count: count))
    }
}


// MARK: - Previews

struct ItemDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ItemDetailsView(item: .stone, inv: ioc.resolve())
    }
}

