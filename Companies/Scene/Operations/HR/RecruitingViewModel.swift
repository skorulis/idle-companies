//  Created by Alexander Skorulis on 6/8/2022.

import Foundation

final class RecruitingViewModel: CoordinatedViewModel, ObservableObject {
    
    override init() {
        super.init()
        self.inventory.objectWillChange.sink { _ in
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
