//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

final class RecruitingViewModel: CoordinatedViewModel, ObservableObject {
    
    override func onCoordinatorSet() {
        listen(inventory)
        listen(skillStore)
        listen(activityStore)
    }
    
    func listen<T: ObservableObject>(_ obj: T) {
        obj.objectWillChange.sink { [unowned self] _ in
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
