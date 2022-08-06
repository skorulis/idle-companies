//  Created by Alexander Skorulis on 6/8/2022.

import Combine
import Foundation
import XCTest

final class PublisherExpectation: XCTestExpectation {
    
    private var token: AnyCancellable?
    
    init<T: Publisher>(publisher: T, description: String = "Wait for publisher") where T.Failure == Never {
        super.init(description: description)
        token = publisher.sink { output in
            self.fulfill()
        }
    }
    
}
