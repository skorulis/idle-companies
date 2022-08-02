//  Created by Alexander Skorulis on 25/7/2022.

import Foundation

// MARK: - Memory footprint

final class MetallurgyViewModel: CoordinatedViewModel, ObservableObject {
    
    private let skillStore: SkillStore
    let xpCalc: XPLevelCalculation
    
    init(skillStore: SkillStore, xpCalc: XPLevelCalculation) {
        self.skillStore = skillStore
        self.xpCalc = xpCalc
        super.init()
    }
}

// MARK: - Computed values

extension MetallurgyViewModel {
    
    var options: [OperationPath] {
        return [.smelting]
    }
    
    var xp: Int64 {
        skillStore.xp(skill: .metallurgy)
    }
    
}

// MARK: - Logic

extension MetallurgyViewModel {
    
    func show(_ dest: OperationPath) -> () -> Void {
        return { [unowned self] in
            self.coordinator.push(dest)
        }
    }
}
