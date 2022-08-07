//  Created by Alexander Skorulis on 7/8/2022.

import Foundation
@testable import Companies
import XCTest

final class EnhancementCalculationTests: XCTestCase {

    let sut = EnhancementCalculation()
    
    func test_cost() {
        XCTAssertEqual(sut.cost(1), 1250)
        XCTAssertEqual(sut.cost(2), 1563)
        XCTAssertEqual(sut.cost(3), 1954)
        XCTAssertEqual(sut.cost(5), 3052)
        XCTAssertEqual(sut.cost(10), 9314)
        XCTAssertEqual(sut.cost(20), 86737)
        XCTAssertEqual(sut.cost(30), 807794)
    }

}

