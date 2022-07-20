//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

final class InMemoryDefaults {
    
    var storage: [String: Any] = [:]
    
    init() {}
    
}

extension InMemoryDefaults: PKeyValueStore {
    func data(forKey: String) -> Data? {
        return storage[forKey] as? Data
    }
    
    func set(_ value: Any?, forKey: String) {
        if let value = value {
            storage[forKey] = value
        } else {
            storage.removeValue(forKey: forKey)
        }
    }
    
    
}
