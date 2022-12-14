//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

#if DEBUG

final class DebugTimeProvider: PTimeProvider {
    
    private let real = TimeProvider()
    private var offset: TimeInterval = 0
    
    var time: Date { real.time + offset }
    var speed: TimeInterval = 1
    
    func advance(_ time: TimeInterval) {
        offset += time
    }
    
}


#endif

