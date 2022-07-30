//  Created by Alexander Skorulis on 29/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class ConstructionMaterialsViewModel: CoordinatedViewModel, ObservableObject {
    
    let inventory: InventoryStore
    private let operations: OperationService
    private let uiStore: UIHistoryStore
    private let skillStore: SkillStore
    let xpCalc: XPLevelCalculation
    
    @Published var selected: ConstructionMaterialActivity
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(inventory: InventoryStore,
         operations: OperationService,
         uiStore: UIHistoryStore,
         skillStore: SkillStore,
         xpCalc: XPLevelCalculation
    ) {
        self.inventory = inventory
        self.operations = operations
        self.uiStore = uiStore
        self.skillStore = skillStore
        self.xpCalc = xpCalc
        selected =  uiStore.retrieve() ?? ConstructionMaterialActivity.allCases[0]
        super .init()
        setupObservers()
    }
    
    private func setupObservers() {
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension ConstructionMaterialsViewModel {
    
    var maybeProgress: OperationProgress? {
        return operations.maybeProgress(selected)
    }
    
    var xp: Int64 {
        skillStore.xp(skill: .construction)
    }
    
}

// MARK: - Logic

extension ConstructionMaterialsViewModel {
    
    func select(_ activity: ConstructionMaterialActivity) {
        self.selected = activity
        uiStore.store(selection: activity)
    }
    
    func start() {
        operations.start(selected)
    }
    
}
