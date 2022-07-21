//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

// MARK: - Memory footprint

final class SkillStore: ObservableObject {
    
    @Published private(set) var experience: [Skill: SkillExperience] = [:]
    
    private let store: PKeyValueStore
    private static let storageKey = "InventoryStore.storageKey"
    
    init(store: PKeyValueStore) {
        self.store = store
    }
}


// MARK: - Logic

extension SkillStore {
    
    func addXP(skill: Skill, xp: Int64, operationID: String?) {
        var data = experience[skill] ?? SkillExperience()
        data.main += xp
        if let opID = operationID {
            data.add(op: opID, xp: xp)
        }
        experience[skill] = data
        
    }
    
    func xp(skill: Skill) -> Int64 {
        return experience[skill]?.main ?? 0
    }
    
    func xp(skill: Skill, operationID: String) -> Int64 {
        return experience[skill]?.operations[operationID] ?? 0
    }
}
