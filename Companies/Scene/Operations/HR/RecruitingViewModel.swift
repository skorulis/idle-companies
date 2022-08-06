//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

final class RecruitingViewModel: CoordinatedViewModel, ObservableObject {
    
    let operations: OperationService
    
    init(operations: OperationService) {
        self.operations = operations
        super.init()
    }
    
    override func onCoordinatorSet() {
        inventory.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
        
        skillStore.objectWillChange.sink { [unowned self] _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
        
        activityStore.objectWillChange.sink { [unowned self] _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
}

// MARK: - Computed values

extension RecruitingViewModel {
    
    var xp: Int64 {
        skillStore.xp(skill: .hr)
    }
    
}

// MARK: - Logic

extension RecruitingViewModel {
    
    func onPress(_ type: RecruitingActivity) -> () -> Void {
        return { [unowned self] in
            self.operations.start(type)
        }
    }
    
    func maybeProgress(_ place: RecruitingActivity) -> OperationProgress? {
        operations.store.maybeProgress(place)
    }
}
