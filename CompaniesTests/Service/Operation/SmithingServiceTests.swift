//  Created by Alexander Skorulis on 20/7/2022.


import Foundation
@testable import Companies
import XCTest

final class SmithingServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var inv = ioc.resolve(InventoryStore.self)
    private lazy var sut = ioc.resolve(SmithingService.self)
 
    func test_start() {
        XCTAssertThrowsError(try sut.start(sut.ironBarRecipe))
        
        inv.add(item: .ironOre, count: 1)
        
        XCTAssertNoThrow(try sut.start(sut.ironBarRecipe))
    }
    
}

