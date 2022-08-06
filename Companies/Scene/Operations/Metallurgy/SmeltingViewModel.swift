//  Created by Alexander Skorulis on 20/7/2022.

import Combine
import Foundation

// MARK: - Memory footprint

final class SmeltingViewModel: CoordinatedViewModel, ObservableObject {

    private let uiStore: UIHistoryStore
    
    @Published var selectedRecipe: SmeltingActivity
    
    init(uiStore: UIHistoryStore
    ) {
        self.uiStore = uiStore
        selectedRecipe =  uiStore.retrieve() ?? SmeltingActivity.allCases[0]
        super.init()
    }
    
    override func onCoordinatorSet() {
        activityStore.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
        
        inventory.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension SmeltingViewModel {
    
    var recipes: [SmeltingActivity] {
        SmeltingActivity.allCases
    }
    
    var maybeProgress: OperationProgress? {
        operations.store.maybeProgress(selectedRecipe)
    }
    
    var xp: Int64 {
        skillStore.xp(skill: .metallurgy)
    }
}

// MARK: - Logic

extension SmeltingViewModel {
 
    func recipePressed(_ recipe: SmeltingActivity) -> () -> Void {
        return { [unowned self] in
            self.selectedRecipe = recipe
            self.uiStore.store(selection: recipe)
        }
    }
    
    func startSmithing() {
        operations.start(selectedRecipe)
    }
    
}
