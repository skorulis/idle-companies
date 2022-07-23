//  Created by Alexander Skorulis on 22/7/2022.

import Foundation
@testable import Companies
import XCTest

final class XPLevelCalculationTests: XCTestCase {

    let sut = XPLevelCalculation()
    
    func test_xpCalculation() {
        XCTAssertEqual(sut.totalXP(1), 0)
        
        XCTAssertEqual(sut.totalXP(2), 63)
        XCTAssertEqual(sut.totalXP(3), 141)
        XCTAssertEqual(sut.totalXP(4), 239)
        XCTAssertEqual(sut.totalXP(5), 361)
        XCTAssertEqual(sut.totalXP(10), 1613)
        XCTAssertEqual(sut.totalXP(20), 17098)
        XCTAssertEqual(sut.totalXP(35), 492789)
        XCTAssertEqual(sut.totalXP(50), 14012735)
        XCTAssertEqual(sut.totalXP(100), 981818692810)
    }
    
    func test_levelCalculation() {
        XCTAssertEqual(sut.level(0), 1)
        XCTAssertEqual(sut.level(50), 1)
        XCTAssertEqual(sut.level(200), 3)
        XCTAssertEqual(sut.level(1500), 9)
        XCTAssertEqual(sut.level(1613), 10)
        XCTAssertEqual(sut.level(492788), 34)
        XCTAssertEqual(sut.level(492789), 35)
    }
    
    func test_reversal() {
        let xp2 = sut.totalXP(2)
        XCTAssertEqual(sut.level(xp2), 2)
        
        let xp5 = sut.totalXP(5)
        XCTAssertEqual(sut.level(xp5), 5)
        
        let xp50 = sut.totalXP(50)
        XCTAssertEqual(sut.level(xp50), 50)
        
        let xp99 = sut.totalXP(99)
        XCTAssertEqual(sut.level(xp99), 99)

    }
    
    func test_allReversal() {
        for i in 2...99 {
            let xpReq = sut.totalXP(i)
            XCTAssertEqual(sut.level(xpReq), i)
            let back1 = xpReq - 1
            XCTAssertEqual(sut.level(back1), i - 1)
        }
    }

}
