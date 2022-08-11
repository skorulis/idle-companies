//  Created by Alexander Skorulis on 8/8/2022.

import Foundation

// MARK: - Memory footprint

final class ManageEnhancementsViewModel: CoordinatedViewModel, ObservableObject {
    
    private let enhancementService: EnhancementService
    private let companyStore: CompanyStore
    private let uiStore: UIHistoryStore
    
    @Published var selected: Enhancement {
        didSet {
            uiStore.store(selection: selected)
        }
    }
    
    init(enhancementService: EnhancementService,
         companyStore: CompanyStore,
         uiStore: UIHistoryStore
    ) {
        self.enhancementService = enhancementService
        self.companyStore = companyStore
        self.uiStore = uiStore
        selected = uiStore.retrieve() ?? Enhancement.allCases[0]
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
    
    var currentCost: [ItemCount] {
        enhancementService.cost(selected)
    }
    
    var selectedLevel: Int {
        companyStore.level(enhancement: selected)
    }
    
    func select(_ enhancement: Enhancement) -> () -> Void {
        return {
            self.selected = enhancement
        }
    }
    
    func downgrade() {
        guard selectedLevel > 0 else { return }
        companyStore.company.enhancements[selected] = selectedLevel - 1
    }
    
}
