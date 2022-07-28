//  Created by Alexander Skorulis on 27/7/2022.

import Foundation

// MARK: - Memory footprint

final class ConstructionViewModel: CoordinatedViewModel, ObservableObject {
    
    private let skillStore: SkillStore
    let xpCalc: XPLevelCalculation
    
    init(skillStore: SkillStore, xpCalc: XPLevelCalculation) {
        self.skillStore = skillStore
        self.xpCalc = xpCalc
        super.init()
    }
    
}

// MARK: - Computed values

extension ConstructionViewModel {
    
    var xp: Int64 {
        skillStore.xp(skill: .construction)
    }
}

// MARK: - Logic

extension ConstructionViewModel {
    
    func show(_ type: ConstructionSubType) -> () -> Void {
        return { [unowned self] in
            self.coordinator.push(.construction(type))
        }
    }
}
