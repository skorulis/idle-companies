//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

struct ItemCount: Identifiable {
    let item: ItemType
    let count: Int
    
    var id: String {
        return "\(item.rawValue)-\(count)"
    }
}
