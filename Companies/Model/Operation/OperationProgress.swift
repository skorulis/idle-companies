//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

struct OperationProgress {
    
    let operation: POperation
    let timing: TaskTiming
    let lastTick: Date
    
    var timer: Timer?
    
}
