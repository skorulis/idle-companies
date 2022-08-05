//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct InventoryView {
    
    @StateObject var viewModel: InventoryViewModel
    
}

// MARK: - Rendering

extension InventoryView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
            .sheet(item: $viewModel.selectedItem) { item in
                ItemDetailsView(item: item, inv: viewModel.inventoryStore)
            }
    }
    
    private func nav() -> some View {
        NavBar(left: EmptyView(), mid: BarButtonItem.title("Warehouse"))
    }
    
    private func content() -> some View {
        VStack {
            credits
            grid
        }
    }
    
    private var credits: some View {
        HStack {
            Text("Credits")
            Spacer()
            Text(ShortNumberFormatter.standard.format(viewModel.inventoryStore.credits))
        }
        .padding(.horizontal, 16)
    }
    
    private var grid: some View {
        let columns = [GridItem(.flexible()),
                       GridItem(.flexible()),
                       GridItem(.flexible()),
                       GridItem(.flexible())
        ]

        return LazyVGrid(columns: columns,
                  alignment: .center,
                  spacing: 4) {
            ForEach(viewModel.inventory) { item in
                Button(action: viewModel.onClick(item)) {
                    ItemCountView(item: item)
                        .contentShape(Rectangle())
                }
            }
        }
    }
    
}

// MARK: - Previews

struct InventoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let store = ioc.resolve(InventoryStore.self)
        try! store.add(item: .goldBar, count: 5)
        try! store.add(item: .ironOre, count: 15)
        return InventoryView(viewModel: ioc.resolve())
    }
}

