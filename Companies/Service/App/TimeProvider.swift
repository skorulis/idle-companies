//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

/// Protocol to provide information about time
protocol PTimeProvider {
    
    /// Current time
    var time: Date { get }
    
    /// Speed the game is running at
    var speed: TimeInterval { get }
}


final class TimeProvider: PTimeProvider {
    
    var time: Date {
        return Date()
    }
    
    var speed: TimeInterval {
        return 1
    }
    
}

