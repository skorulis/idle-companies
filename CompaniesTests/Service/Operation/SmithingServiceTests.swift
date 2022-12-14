//  Created by Alexander Skorulis on 20/7/2022.


import Foundation
@testable import Companies
import XCTest

final class SmithingServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var inv = ioc.resolve(InventoryStore.self)
    private lazy var sut = ioc.resolve(SmeltingActivity.Service.self)
 
    func test_start() throws {
        XCTAssertThrowsError(try sut.tryStart(activity: SmeltingActivity.ironBar))
        
        try inv.add(item: .ironOre, count: 2)
        
        XCTAssertNoThrow(try sut.tryStart(activity: SmeltingActivity.ironBar))
    }
    
}

