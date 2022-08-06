//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

// MARK: - Memory footprint

final class HQUpgradeViewModel: CoordinatedViewModel, ObservableObject {
    
    let inventory: InventoryStore
    private let company: CompanyStore
    
    init(inventory: InventoryStore, company: CompanyStore) {
        self.inventory = inventory
        self.company = company
        super.init()
        company.objectWillChange.sink { [unowned self] in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension HQUpgradeViewModel {
    
    var type: HQType? {
        return company.company.hqType.next
    }
    
    var canUpgrade: Bool {
        guard let type = type else { return false }
        return inventory.containsAll(items: type.requirements)
    }
    
}

// MARK: - Logic

extension HQUpgradeViewModel {
 
    func upgrade() {
        guard let type = type, canUpgrade else { return }
        
        inventory.removeAll(items: type.requirements)
        company.company.hqType = type
    }
}
