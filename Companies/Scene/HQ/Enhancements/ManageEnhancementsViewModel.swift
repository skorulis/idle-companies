//  Created by Alexander Skorulis on 8/8/2022.

import Foundation

// MARK: - Memory footprint

final class ManageEnhancementsViewModel: CoordinatedViewModel, ObservableObject {
    
    private let enhancementService: EnhancementService
    private let companyStore: CompanyStore
    
    init(enhancementService: EnhancementService,
         companyStore: CompanyStore
    ) {
        self.enhancementService = enhancementService
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

// MARK: - Computed

extension ManageEnhancementsViewModel {
    
    var available: [Enhancement] {
        Enhancement.allCases
    }
    
}


// MARK: - Logic

extension ManageEnhancementsViewModel {
    
    func levelsString(_ enhancement: Enhancement) -> String {
        let level = companyStore.level(enhancement: enhancement)
        return "\(level) / \(enhancement.maxLevel)"
    }
    
    func purchase(_ enhancement: Enhancement) {
        enhancementService.purchase(enhancement)
    }
    
}
