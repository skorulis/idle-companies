//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

#if DEBUG

final class DebugTimeProvider: PTimeProvider {
    
    private let real = TimeProvider()
    
    var time: Date { real.time }
    var speed: TimeInterval = 1
    
}


#endif

