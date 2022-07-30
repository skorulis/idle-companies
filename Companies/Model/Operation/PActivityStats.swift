//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

protocol PActivityStats {
    var duration: TimeInterval { get }
}

struct BasicActivityStats: PActivityStats {
    let duration: TimeInterval
}
