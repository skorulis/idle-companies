//  Created by Alexander Skorulis on 28/7/2022.

import Foundation

final class CompanyStore: ObservableObject {

    private let store: PKeyValueStore
    private static let storageKey = "CompanyStore.storageKey"
    
    @Published var company: CompanyModel
    
    init(store: PKeyValueStore) {
        self.store = store
        self.company = Self.readFromDisk(store: store)
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
