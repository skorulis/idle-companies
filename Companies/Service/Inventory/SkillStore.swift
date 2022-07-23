//  Created by Alexander Skorulis on 21/7/2022.

import Foundation

// MARK: - Memory footprint

final class SkillStore: ObservableObject {
    
    @Published private(set) var experience: [Skill: SkillExperience] = [:] {
        didSet {
            writeToDisk()
        }
    }
    
    private let store: PKeyValueStore
    private static let storageKey = "SkillStore.storageKey"
    
    init(store: PKeyValueStore) {
        self.store = store
        let data = Self.readFromDisk(store: store)
        experience = data.experience
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

// MARK: - Inner types

private extension SkillStore {
    struct DiskStorage: Codable {
        let experience: [Skill: SkillExperience]
    }
}


// MARK: - Private logic

private extension SkillStore {
    
    func writeToDisk() {
        let storage = DiskStorage(experience: experience)
        try! store.set(codable: storage, forKey: Self.storageKey)
    }
    
    static func readFromDisk(store: PKeyValueStore) -> DiskStorage {
        if let item: DiskStorage = try? store.codable(forKey: Self.storageKey) {
            return item
        }
        return DiskStorage(experience: [:])
    }
    
}
