//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemIconView {
    let item: ItemType
}

// MARK: - Rendering

extension ItemIconView: View {
    
    var body: some View {
        Image(systemName: "bag.circle")
    }
}

// MARK: - Previews

struct ItemIconView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemIconView(item: .goldIngot)
    }
}

