//  Created by Alexander Skorulis on 2/8/2022.

import Foundation
@testable import Companies
import XCTest

final class ShortNumberFormatterTests: XCTestCase {

    let sut = ShortNumberFormatter()
    
    func test_intFormatting() {
        XCTAssertEqual(sut.format(1), "1")
        XCTAssertEqual(sut.format(100), "100")
        XCTAssertEqual(sut.format(999), "999")
        
        XCTAssertEqual(sut.format(1000), "1K")
        XCTAssertEqual(sut.format(1100), "1.1K")
        XCTAssertEqual(sut.format(1090), "1.1K")
        
        XCTAssertEqual(sut.format(20500), "20.5K")
        
        XCTAssertEqual(sut.format(1000000), "1M")
        XCTAssertEqual(sut.format(900000), "900K")
    }
    
    func test_intNegative() {
        XCTAssertEqual(sut.format(-1), "-1")
        XCTAssertEqual(sut.format(-100), "-100")
        XCTAssertEqual(sut.format(-999), "-999")
        
        XCTAssertEqual(sut.format(-1000), "-1K")
        XCTAssertEqual(sut.format(-1100), "-1.1K")
        XCTAssertEqual(sut.format(-1090), "-1.1K")
        
        XCTAssertEqual(sut.format(-20500), "-20.5K")
        
        XCTAssertEqual(sut.format(-1000000), "-1M")
        XCTAssertEqual(sut.format(-900000), "-900K")
    }

}


