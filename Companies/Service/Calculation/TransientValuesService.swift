//  Created by Alexander Skorulis on 3/8/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

/// Service which does a lot of calculations up front to make the data easier to use
final class TransientValuesService {
    
    private let store: TransientValuesStore
    private let factory: PFactory
    private lazy var companyStore: CompanyStore = factory.resolve()
    
    init(store: TransientValuesStore, factory: PFactory) {
        self.store = store
        self.factory = factory
    }
}

// MARK: - Logic

extension TransientValuesService {
    
    func calculateValues() {
        store.inventorySize = inventorySize
    }
}

// MARK: - Logic (Private)

private extension TransientValuesService {
 
    var inventorySize: Int {
        companyStore.company.hqType.inventorySpots
    }
    
}
