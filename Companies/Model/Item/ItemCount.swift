//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

public struct ItemCount: Identifiable {
    public let type: ItemType
    public let count: Int
    
    private static let formatter = ShortNumberFormatter()
    
    public var id: String {
        return "\(type.rawValue)-\(count)"
    }
    
    public var shortCountText: String {
        Self.formatter.format(count)
    }
}
