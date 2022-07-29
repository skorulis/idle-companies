//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemIconView {
    private let item: ItemType
    private let size: CGFloat
    
    init(item: ItemType, size: CGFloat = 28) {
        self.item = item
        self.size = size
    }
}

// MARK: - Rendering

extension ItemIconView: View {
    
    var body: some View {
        item.icon.image(28)
            .foregroundColor(item.color)
    }
}

// MARK: - Previews

struct ItemIconView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemIconView(item: .goldBar)
    }
}

