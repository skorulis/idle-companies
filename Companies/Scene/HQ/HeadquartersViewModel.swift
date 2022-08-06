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
        super.init()
        
        inventoryStore.objectWillChange.sink { [unowned self] in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
        
        companyStore.objectWillChange.sink { [unowned self] in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
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
    
    var canUpgrade: Bool {
        guard let next = hq.next else { return false }
        return inventoryStore.containsAll(items: next.requirements)
    }
}

// MARK: - Logic

extension HeadquartersViewModel {
    
    func showUpgrade() {
        coordinator.push(.hq(.upgrade))
    }
}
