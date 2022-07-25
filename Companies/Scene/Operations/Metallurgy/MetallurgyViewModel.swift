//  Created by Alexander Skorulis on 25/7/2022.

import Foundation

// MARK: - Memory footprint

final class MetallurgyViewModel: ObservableObject {
    
    @Published var selectedDestination: Destination?
    
    init() {
        
    }
}

// MARK: - Inner types

extension MetallurgyViewModel {
    
    enum Destination: String, Identifiable, CaseIterable {
        
        case smelting
        case alloys
        
        var id: String { rawValue }
    }
}

// MARK: - Logic

extension MetallurgyViewModel {
    
    func show(_ dest: Destination) -> () -> Void {
        return { [unowned self] in
            self.selectedDestination = dest
        }
    }
}
