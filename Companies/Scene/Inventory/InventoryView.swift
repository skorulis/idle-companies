//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct InventoryView {
    
    @StateObject var viewModel: InventoryViewModel
    
}

// MARK: - Rendering

extension InventoryView: View {
    
    var body: some View {
        grid
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
                itemView(item)
            }
        }
    }
    
    private func itemView(_ item: ItemCount) -> some View {
        VStack {
            ItemIconView(item: item.item)
            Text("\(item.count)")
        }
    }
}

// MARK: - Previews

struct InventoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        InventoryView(viewModel: ioc.resolve())
    }
}

