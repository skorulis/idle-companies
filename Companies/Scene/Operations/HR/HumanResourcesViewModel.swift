//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

final class HumanResourcesViewModel: CoordinatedViewModel, ObservableObject {
    
    override init() {
        super.init()
    }
    
    override func onCoordinatorSet() {
        skillStore.objectWillChange.sink { [unowned self] in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
}

// MARK: - Computed values

extension HumanResourcesViewModel {
    
    var xp: Int64 {
        skillStore.xp(skill: .hr)
    }
}

// MARK: - Logic

extension HumanResourcesViewModel {
    
    func show(_ type: HRSubType) -> () -> Void {
        return { [unowned self] in
            self.coordinator.push(.hr(type))
        }
    }
}
