//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

final class CompanyStore: ObservableObject {

    private let store: PKeyValueStore
    private static let storageKey = "CompanyStore.storageKey"
    
    @Published var company: CompanyModel {
        didSet {
            try! self.store.set(codable: company, forKey: Self.storageKey)
        }
    }
    
    init(store: PKeyValueStore) {
        self.store = store
        self.company = Self.readFromDisk(store: store)
    }
    
}

extension CompanyStore {
    
    var allModifiers: [StatModifier] {
        var all = [StatModifier]()
        for (key, value) in company.enhancements {
            let mods = key.modifiers.map { $0 * Double(value) }
            all.append(contentsOf: mods)
        }
        return all
    }
    
}


// MARK: - Logic

extension CompanyStore {
    
    func level(enhancement: Enhancement) -> Int {
        return company.enhancements[enhancement] ?? 0
    }
    
}


// MARK: - Private logic

private extension CompanyStore {
    
    static func readFromDisk(store: PKeyValueStore) -> CompanyModel {
        if let company: CompanyModel = try? store.codable(forKey: Self.storageKey) {
            return company
        }
        return CompanyModel(hqType: .basic)
    }
    
}
