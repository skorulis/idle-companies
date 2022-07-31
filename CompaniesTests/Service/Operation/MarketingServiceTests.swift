//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
@testable import Companies
import XCTest

final class MarketingServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var inv = ioc.resolve(InventoryStore.self)
    private lazy var sut = ioc.resolve(MarketingActivity.Service.self)
 
    func test_finish() {
        sut.finish(activity: .radio)
        
        XCTAssertEqual(inv.count(item: .credits), 2)
    }
    
}


