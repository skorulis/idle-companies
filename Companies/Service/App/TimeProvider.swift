//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

/// Protocol to provide information about time
protocol PTimeProvider {
    
    var time: Date { get }
    
}


final class TimeProvider: PTimeProvider {
    
    var time: Date {
        return Date()
    }
    
}

