//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

final class EducationViewModel: CoordinatedViewModel, ObservableObject {
    
    private let uiStore: UIHistoryStore
    
    @Published var selected: EducationActivity
    
    init(uiStore: UIHistoryStore) {
        self.uiStore = uiStore
        selected = uiStore.retrieve() ?? EducationActivity.allCases[0]
        super.init()
    }
    
    override func onCoordinatorSet() {
        activityStore.objectWillChange.sink { [unowned self] in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
    
}

// MARK: - Computed values

extension EducationViewModel {
    
    var xp: Int64 {
        skillStore.xp(skill: .hr)
    }
    
    var maybeProgress: OperationProgress? {
        return operations.store.maybeProgress(selected)
    }
    
}

// MARK: - Logic

extension EducationViewModel {
    
    func select(_ activity: EducationActivity) {
        self.selected = activity
        uiStore.store(selection: activity)
    }
    
    func start() {
        operations.start(selected)
    }
    
}
