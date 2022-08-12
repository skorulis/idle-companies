//  Created by Alexander Skorulis on 12/8/2022.

import Foundation

// MARK: - Memory footprint

final class MilitaryViewModel: CoordinatedViewModel, ObservableObject {
    
}

// MARK: - Computed

extension MilitaryViewModel {
    var xp: Int64 {
        skillStore.xp(skill: .military)
    }
}

// MARK: - Logic

extension MilitaryViewModel {
    
    func show(_ type: MilitarySubType) -> () -> Void {
        return { [unowned self] in
            self.coordinator.push(.military(type))
        }
    }
    
}
