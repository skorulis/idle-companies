//  Created by Alexander Skorulis on 21/7/2022.

#if DEBUG

import Foundation

// MARK: - Memory footprint

final class DebugViewModel: ObservableObject {
 
    let timeProvider: DebugTimeProvider
    
    @Published var speed: TimeInterval {
        didSet {
            timeProvider.speed = speed
        }
    }
    
    init(timeProvider: PTimeProvider) {
        self.timeProvider = timeProvider as! DebugTimeProvider
        _speed = Published(wrappedValue: self.timeProvider.speed)
    }
    
}

// MARK: - Computed values

extension DebugViewModel {
 
    
}

// MARK: - Logic

extension DebugViewModel {
    
    
}

#endif
