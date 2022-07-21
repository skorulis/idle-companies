//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

public protocol OperationInfo {
    
    var id: String { get }
    var name: String { get }
    var baseTime: TimeInterval { get }
    var baseXP: Int64 { get }
    
}
