//  Created by Alexander Skorulis on 1/8/2022.

import Foundation

struct ChangeHistory: Identifiable {
    
    let id: UUID = UUID()
    var items: [ItemType: Int] = [:]
    
    mutating func merge(other: ChangeHistory) {
        for (key, value) in other.items {
            let count = (items[key] ?? 0) + value
            items[key] = count
        }
    }
    
    var isEmpty: Bool {
        return items.count == 0
    }
    
}
