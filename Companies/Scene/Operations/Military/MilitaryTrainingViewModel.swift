//  Created by Alexander Skorulis on 12/8/2022.

import Foundation

// MARK: - Memory footprint

final class MilitaryTrainingViewModel: CoordinatedViewModel, ObservableObject {
    
    @Published var selectedIndex: Int = 0
}


// MARK: - Computed

extension MilitaryTrainingViewModel {
    var xp: Int64 {
        skillStore.xp(skill: .military)
    }
    
}
