//  Created by Alexander Skorulis on 13/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattalionList {
    
    @ObservedObject var inventory: InventoryStore
    
}

// MARK: - Rendering

extension BattalionList: View {
    
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                BattalionSummaryView(battalion: battalion(index: index))
            }
        }
    }
    
    private func battalion(index: Int) -> Battalion {
        return inventory.battalions[index] ?? .empty
    }
}

// MARK: - Previews

struct BattalionList_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        BattalionList(inventory: ioc.resolve())
    }
}

