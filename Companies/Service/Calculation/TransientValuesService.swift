//  Created by Alexander Skorulis on 3/8/2022.

import ASKCore
import Combine
import Foundation

// MARK: - Memory footprint

/// Service which does a lot of calculations up front to make the data easier to use
final class TransientValuesService {
    
    private let store: TransientValuesStore
    private let factory: PFactory
    private lazy var companyStore: CompanyStore = factory.resolve()
    
    private var subscribers: Set<AnyCancellable> = []
    
    init(store: TransientValuesStore, factory: PFactory) {
        self.store = store
        self.factory = factory
        
        companyStore.objectWillChange.sink { [unowned self] _ in
            DispatchQueue.main.async {
                self.calculateValues()
            }
        }
        .store(in: &subscribers)
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
        let mods = companyStore.allModifiers
        let invMods = StatModifier.total(type: .inventorySize, mods: mods)
        
        return companyStore.company.hqType.inventorySpots + Int(invMods.0)
    }
    
}


