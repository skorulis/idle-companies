//  Created by Alexander Skorulis on 18/7/2022.

import Foundation

// MARK: - Memory footprint

final class OperationListViewModel: ObservableObject {

    @Published var selectedOp: Skill?
    
}

// MARK: - Computed values

extension OperationListViewModel {
    
    var available: [Skill] {
        return [.mining, .marketing, .smithing]
    }
    
}

// MARK: - Logic

extension OperationListViewModel {
    
    func show(_ skill: Skill) -> () -> Void {
        return { [unowned self] in
            self.selectedOp = skill
        }
    }
    
}
