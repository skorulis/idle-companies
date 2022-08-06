//  Created by Alexander Skorulis on 27/7/2022.

import Foundation

// MARK: - Memory footprint

final class ConstructionViewModel: CoordinatedViewModel, ObservableObject {
    
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
