//  Created by Alexander Skorulis on 1/8/2022.

import Foundation
@testable import Companies
import XCTest

final class OperationProgressTests: XCTestCase {
    
    func test_miningEncoding() throws {
        let prog = OperationProgress(operation: MiningActivity.beach, timing: .init(startTime: 10, duration: 20))
        let data = try JSONEncoder().encode(prog)
        
        let decoded = try JSONDecoder().decode(OperationProgress.self, from: data)
        
        XCTAssertEqual(prog.operation.id, decoded.operation.id)
    }
    
    func test_marketingEncoding() throws {
        let prog = OperationProgress(operation: MarketingActivity.newspaper, timing: .init(startTime: 10, duration: 20))
        let data = try JSONEncoder().encode(prog)
        
        let decoded = try JSONDecoder().decode(OperationProgress.self, from: data)
        
        XCTAssertEqual(prog.operation.id, decoded.operation.id)
    }
    
}




