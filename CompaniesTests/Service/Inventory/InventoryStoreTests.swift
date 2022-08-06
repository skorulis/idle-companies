//  Created by Alexander Skorulis on 6/8/2022.

import Foundation
@testable import Companies
import XCTest

final class InventoryStoreTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var sut = ioc.resolve(InventoryStore.self)
 
    func test_itemCount() throws {
        XCTAssertEqual(sut.itemCount, 0)
        try sut.add(item: ItemCount(type: .goldBar, count: 1))
        XCTAssertEqual(sut.itemCount, 1)
        try sut.add(item: ItemCount(type: .credits, count: 1))
        XCTAssertEqual(sut.itemCount, 1)
        
        try sut.add(item: ItemCount(type: .goldBar, count: 1))
        XCTAssertEqual(sut.itemCount, 1)
        
        try sut.add(item: ItemCount(type: .ironBar, count: 1))
        XCTAssertEqual(sut.itemCount, 2)
    }
    
}
