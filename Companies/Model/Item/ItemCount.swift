//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

struct ItemCount: Identifiable {
    let type: ItemType
    let count: Int
    
    var id: String {
        return "\(type.rawValue)-\(count)"
    }
}
