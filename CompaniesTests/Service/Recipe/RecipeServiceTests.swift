//  Created by Alexander Skorulis on 20/7/2022.

import Foundation
@testable import Companies
import XCTest

final class RecipeServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var inv = ioc.resolve(InventoryStore.self)
    private lazy var sut = ioc.resolve(RecipeService.self)
    
    func test_consume() throws {
        XCTAssertThrowsError(try sut.consume(inputs: inputs))
        
        try inv.add(item: .ironOre, count: 1)
        
        XCTAssertNoThrow(try sut.consume(inputs: inputs))
        
        XCTAssertEqual(inv.count(item: .ironOre), 0)
    }
    
    func test_finish() throws {
        try sut.finish(outputs: outputs)
        XCTAssertEqual(inv.count(item: .ironBar), 1)
    }
    
    private var inputs: [ItemCount] {
        return [ItemType.ironOre.bundle(1)]
    }
    
    private var outputs: [ItemCount] {
        return [ItemType.ironBar.bundle(1)]
    }
    
}
