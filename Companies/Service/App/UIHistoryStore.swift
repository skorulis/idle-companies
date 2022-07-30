//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

// MARK: - Memory footprint

final class UIHistoryStore: ObservableObject {
    
    @Published var lastSelection: [String: String] = [:]
    
    init() {
        // TODO: Save to disk
    }
}

// MARK: - Logic

extension UIHistoryStore {
    
    func retrieve<T: POperation>() -> T? where T: RawRepresentable, T.RawValue == String {
        guard let stringValue = lastSelection[T.typeID] else { return nil }
        return T(rawValue: stringValue)
    }
    
    func store<T: POperation>(selection: T) {
        lastSelection[T.typeID] = selection.id
    }
    
}
