//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

// MARK: - Memory footprint

final class HeadquartersViewModel: CoordinatedViewModel, ObservableObject {
 
    private let companyStore: CompanyStore
    
    init(companyStore: CompanyStore
    ) {
        self.companyStore = companyStore
        super.init()
        
        
    }
    
    override func onCoordinatorSet() {
        inventory.objectWillChange.sink { [unowned self] in
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
        let values = inventory.inventory.map { (key, value) in
            return key.creditValue * value
        }
        return values.reduce(0, +)
    }
    
    var canUpgrade: Bool {
        guard let next = hq.next else { return false }
        return inventory.containsAll(items: next.requirements)
    }
}

// MARK: - Logic

extension HeadquartersViewModel {
    
    func showUpgrade() {
        coordinator.push(.hq(.upgrade))
    }
}
