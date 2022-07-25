//  Created by Alexander Skorulis on 25/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemDetailsView {
    
    let item: ItemType
}

// MARK: - Rendering

extension ItemDetailsView: View {
    
    var body: some View {
        VStack {
            Text(item.name)
        }
    }
}

// MARK: - Previews

struct ItemDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemDetailsView(item: .stone)
    }
}

