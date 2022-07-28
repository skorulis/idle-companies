//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

final class HQUpgradeViewModel: CoordinatedViewModel, ObservableObject {
    
    private let inventory: InventoryStore
    
    init(inventory: InventoryStore) {
        self.inventory = inventory
        super.init()
    }
    
    
}
