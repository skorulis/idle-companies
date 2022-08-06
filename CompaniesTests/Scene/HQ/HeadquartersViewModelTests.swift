//  Created by Alexander Skorulis on 6/8/2022.

import Foundation
@testable import Companies
import XCTest

final class HeadquartersViewModelTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var sut = ioc.resolve(HeadquartersViewModel.self)
    private lazy var inventoryStore = ioc.resolve(InventoryStore.self)
 
    func test_upgradeState() throws {
        XCTAssertFalse(sut.canUpgrade)
        
        try inventoryStore.addAll(items: HQType.leve1.requirements)
        XCTAssertTrue(sut.canUpgrade)
    }
    
}
