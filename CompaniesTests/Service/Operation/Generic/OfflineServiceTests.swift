//  Created by Alexander Skorulis on 31/7/2022.

import Foundation
@testable import Companies
import XCTest

final class OfflineServiceTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var timeProvider = ioc.resolve(DebugTimeProvider.self)
    private lazy var operationService = ioc.resolve(OperationService.self)
    private lazy var sut = ioc.resolve(OfflineService.self)
    
    func test_next() {
        operationService.start(MiningActivity.beach)
        XCTAssertNil(operationService.nextToFinish)
        
        timeProvider.advance(30)
        XCTAssertNotNil(operationService.nextToFinish)
    }
    
    func test_finish() {
        sut.didEnterBackground()
        operationService.start(MiningActivity.beach)
        timeProvider.advance(30)
        sut.willEnterForeground()
        
        XCTAssertEqual(operationService.finishCount, 6)
    }
    
}


