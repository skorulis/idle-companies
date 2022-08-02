//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

// MARK: - Memory footprint

final class HeadquartersViewModel: CoordinatedViewModel, ObservableObject {
 
    private let companyStore: CompanyStore
    private let inventoryStore: InventoryStore
    
    init(companyStore: CompanyStore,
         inventoryStore: InventoryStore
    ) {
        self.companyStore = companyStore
        self.inventoryStore = inventoryStore
    }
    
}

// MARK: - Computed values

extension HeadquartersViewModel {
    
    var company: CompanyModel  { companyStore.company }
    var name: String { company.name }
    var hq: HQType { company.hqType }
    var networth: Int {
        let values = inventoryStore.inventory.map { (key, value) in
            return key.creditValue * value
        }
        return values.reduce(0, +)
    }
}

// MARK: - Logic

extension HeadquartersViewModel {
    
    func showUpgrade() {
        coordinator.push(.hq(.upgrade))
    }
}
