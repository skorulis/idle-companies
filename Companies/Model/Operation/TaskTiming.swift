//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

struct TaskTiming: Codable {
    
    let startTime: TimeInterval
    let duration: TimeInterval
    
    var elapsed: TimeInterval {
        Date().timeIntervalSince1970 - startTime
    }
    
    func remaining(_ time: PTimeProvider) -> TimeInterval {
        let elapsed = time.seconds - startTime
        return duration - elapsed
    }
    
    var currentPct: CGFloat {
        let prog = elapsed / duration
        return max(min(prog, 1), 0)
    }
    
    var id: String {
        return "\(startTime)-\(duration)"
    }
    
    var finishTime: TimeInterval {
        startTime + duration
    }
}
