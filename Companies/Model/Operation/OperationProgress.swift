//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

struct OperationProgress {
    
    let operation: any POperation
    let timing: TaskTiming
    
    var status: ActivityStatus
    
    var timer: Timer? {
        if case let .active(timer) = status {
            return timer
        }
        return nil
    }
    
    var finishTime: TimeInterval { timing.finishTime }
}

enum ActivityStatus {
    
    case active(timer: Timer)
    case paused
    case stalled
}
