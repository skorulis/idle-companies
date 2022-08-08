//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

// MARK: - Memory footprint

final class HeadquartersViewModel: CoordinatedViewModel, ObservableObject {
 
    private let companyStore: CompanyStore
    private let enhancementCalc: EnhancementCalculation
    private let toastService: ToastPresentationService
    
    init(companyStore: CompanyStore,
         enhancementCalc: EnhancementCalculation,
         toastService: ToastPresentationService
    ) {
        self.companyStore = companyStore
        self.enhancementCalc = enhancementCalc
        self.toastService = toastService
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
    
    var availableEnhancementSlots: Int {
        totalEnhancementSlots
    }
    
    var totalEnhancementSlots: Int {
        company.enhancementSlots
    }
    
    var nextEnhancementCost: Int {
        enhancementCalc.cost(totalEnhancementSlots + 1)
    }
    
    var nextCostString: String {
        ShortNumberFormatter.standard.format(nextEnhancementCost)
    }
    
    var canBuyEnhancement: Bool {
        return inventory.contains(item: ItemCount(type: .credits, count: nextEnhancementCost))
    }
}

// MARK: - Logic

extension HeadquartersViewModel {
    
    func showUpgrade() {
        coordinator.push(.hq(.upgrade))
    }
    
    func manageEnhancements() {
        coordinator.push(.hq(.manageEnhancements))
    }
    
    func buyEnhancement() {
        do {
            try inventory.consume(inputs: [ItemCount(type: .credits, count: nextEnhancementCost)])
            companyStore.company.enhancementSlots += 1
        } catch {
            toastService.add(text: error.localizedDescription, style: .negative)
        }
    }
}
