//  Created by Alexander Skorulis on 20/7/2022.

import Foundation
@testable import Companies
import XCTest

final class RecipeServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var inv = ioc.resolve(InventoryStore.self)
    private lazy var sut = ioc.resolve(RecipeService.self)
    
    func test_consume() {
        XCTAssertThrowsError(try sut.consume(recipe: recipe1))
        
        inv.add(item: .ironOre, count: 1)
        
        XCTAssertNoThrow(try sut.consume(recipe: recipe1))
        
        XCTAssertEqual(inv.count(item: .ironOre), 0)
    }
    
    func test_finish() {
        sut.finish(recipe: recipe1)
        XCTAssertEqual(inv.count(item: .ironIngot), 1)
    }
    
    private var recipe1: ItemRecipe {
        return ItemRecipe(name: "TEST",
                          inputs: [ItemType.ironOre.bundle(1)],
                          outputs: [ItemType.ironIngot.bundle(1)])
    }
    
}
