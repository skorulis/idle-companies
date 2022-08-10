//  Created by Alexander Skorulis on 6/8/2022.

import Combine
import Foundation
@testable import Companies
import XCTest

final class TransientValuesServiceTests: XCTestCase {
    
    private let ioc = IOC()
    
    private lazy var store = ioc.resolve(TransientValuesStore.self)
    private lazy var companyStore = ioc.resolve(CompanyStore.self)
    private lazy var sut = ioc.resolve(TransientValuesService.self)
 
    func test_upgradeChange() throws {
        XCTAssertEqual(store.inventorySize, 10)
        
        companyStore.company.hqType = .leve1
        let exp = PublisherExpectation(publisher: store.$inventorySize.dropFirst())
        wait(for: [exp], timeout: 10)
        
        XCTAssertEqual(store.inventorySize, 20)
    }
    
    func test_enhancement() throws {
        companyStore.company.enhancements[.warehouse] = 1
        sut.calculateValues()
        XCTAssertEqual(store.inventorySize, 11)
        
    }
    
}
