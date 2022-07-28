//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

struct CompanyModel: Codable {
    var name: String = "Company"
    var hqType: HQType
    
    init(hqType: HQType) {
        self.hqType = hqType
    }
}
