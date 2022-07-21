//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

public struct ItemPercentage: Identifiable {
    public let type: ItemType
    public let percent: Double
    
    public var id: String {
        return "\(type.rawValue)-\(percent)"
    }
}
