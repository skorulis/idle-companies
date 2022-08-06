//  Created by Alexander Skorulis on 6/8/2022.

import Foundation
import XCTest
@testable import Companies

class IOCTestCase: XCTestCase {
    
    let ioc = IOC(purpose: .testing)
    
    lazy var coordinator = ioc.resolve(GameCoordinator.self, argument: GamePath.empty)
}
