//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

// MARK: - Memory footprint

final class HeadquartersViewModel: CoordinatedViewModel, ObservableObject {
 
    private let companyStore: CompanyStore
    
    init(companyStore: CompanyStore) {
        self.companyStore = companyStore
    }
    
}

// MARK: - Computed values

extension HeadquartersViewModel {
    
    var company: CompanyModel  { companyStore.company }
    var name: String { company.name }
    var hq: HQType { company.hqType }
}

// MARK: - Logic

extension HeadquartersViewModel {
    
    func showUpgrade() {
        coordinator.push(.hq(.upgrade))
    }
}
