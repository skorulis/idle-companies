//  Created by Alexander Skorulis on 11/8/2022.

import Foundation
@testable import Companies
import XCTest

final class BattalionTests: XCTestCase {
    
    func test_init() {
        let bat = Battalion(solider: soldier1)
        
        XCTAssertEqual(bat.value(.accuracy), 10)
        XCTAssertEqual(bat.value(.damage), 11)
        XCTAssertEqual(bat.value(.armor), 12)
        XCTAssertEqual(bat.value(.range), 13)
        XCTAssertEqual(bat.value(.speed), 14)
    }
    
    func test_combine() {
        let bat = Battalion(solider: soldier1)
        let bat2 = bat.merge(soldier2)
        
        XCTAssertEqual(bat2.count, 2)
        XCTAssertEqual(bat2.value(.accuracy), 5)
        XCTAssertEqual(bat2.value(.damage), 8)
        XCTAssertEqual(bat2.value(.armor), 9)
        XCTAssertEqual(bat2.value(.range), 9)
        XCTAssertEqual(bat2.value(.speed), 10)
        
    }
    
    private var soldier1: Soldier {
        Soldier(accuracy: 10, damage: 11, armor: 12, range: 13, speed: 14)
    }
    
    private var soldier2: Soldier {
        Soldier(accuracy: 0, damage: 5, armor: 5, range: 5, speed: 5)
    }
    
}




