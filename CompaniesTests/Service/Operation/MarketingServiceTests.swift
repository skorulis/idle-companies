//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
@testable import Companies
import XCTest

final class MarketingServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var inv = ioc.resolve(InventoryStore.self)
    private lazy var sut = ioc.resolve(MarketingService.self)
 
    func test_finish() {
        sut.onFinish(.radio)
        
        XCTAssertEqual(inv.count(item: .credits), 2)
    }
    
}


