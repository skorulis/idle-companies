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
    
    func retrieve<T: RawRepresentable>() -> T? where T.RawValue == String {
        let tid = String(describing: T.self)
        guard let stringValue = lastSelection[tid] else { return nil }
        return T(rawValue: stringValue)
    }
    
    func store<T: RawRepresentable>(selection: T) where T.RawValue == String {
        lastSelection[typeID(item: selection)] = selection.rawValue
    }
    
    private func typeID<T>(item: T) -> String {
        return String(describing: type(of: item))
    }
    
}
