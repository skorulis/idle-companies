//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
@testable import Companies
import XCTest

final class SkillStoreTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var sut = ioc.resolve(SkillStore.self)
 
    func test_addXP() {
        sut.addXP(skill: .mining, xp: 25, operationID: "stuff")
        XCTAssertEqual(sut.xp(skill: .mining), 25)
        XCTAssertEqual(sut.xp(skill: .mining, operationID: "stuff"), 25)
        XCTAssertEqual(sut.xp(skill: .mining, operationID: "bogus"), 0)
        
        sut.addXP(skill: .mining, xp: 25, operationID: nil)
        XCTAssertEqual(sut.xp(skill: .mining), 50)
        XCTAssertEqual(sut.xp(skill: .mining, operationID: "stuff"), 25)
        XCTAssertEqual(sut.xp(skill: .mining, operationID: "bogus"), 0)
        
    }
    
}
