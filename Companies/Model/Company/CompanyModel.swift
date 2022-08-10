//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

struct CompanyModel: Codable {
    var name: String = "Company"
    var hqType: HQType
    
    /// Total upgrades purchased
    var enhancementSlots: Int
    
    /// Applied enhancements
    var enhancements: [Enhancement: Int]
    
    init(hqType: HQType) {
        self.hqType = hqType
        self.enhancementSlots = 0
        enhancements = [:]
    }
}
