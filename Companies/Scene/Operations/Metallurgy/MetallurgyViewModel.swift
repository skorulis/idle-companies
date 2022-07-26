//  Created by Alexander Skorulis on 25/7/2022.

import Foundation

// MARK: - Memory footprint

final class MetallurgyViewModel: CoordinatedViewModel, ObservableObject {
    
    override init() {
        
    }
}

// MARK: - Computed values

extension MetallurgyViewModel {
    
    var options: [OperationPath] {
        return [.smelting]
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
