//  Created by Alexander Skorulis on 1/8/2022.

import Foundation

struct ChangeHistory: Identifiable {
    
    let id: UUID = UUID()
    var items: [ItemType: Int] = [:]
    
}
