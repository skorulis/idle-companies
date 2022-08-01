//  Created by Alexander Skorulis on 1/8/2022.

import Foundation

final class ActivityStore: ObservableObject {
    
    private let diskStore: PKeyValueStore
    
    @Published var active: [OperationProgress] = [] {
        didSet {
            try! self.diskStore.set(codable: active, forKey: Self.storageKey)
        }
    }
    private static let storageKey = "ActivityStore.storageKey"
    
    init(diskStore: PKeyValueStore) {
        self.diskStore = diskStore
        self.active = Self.readFromDisk(store: diskStore)
    }
}

// MARK: - Logic

extension ActivityStore {
    
    var lastStartTime: TimeInterval? {
        return active.map { $0.timing.startTime }.max()
    }
    
    func maybeProgress<T: POperation>(_ op: T?) -> OperationProgress? {
        guard let op = op else { return nil }
        return active.first { progress in
            return progress.operation.matches(op)
        }
    }
}

// MARK: - Logic (private)

private extension ActivityStore {
    
    static func readFromDisk(store: PKeyValueStore) -> [OperationProgress] {
        if let inventory: [OperationProgress] = try? store.codable(forKey: Self.storageKey) {
            return inventory
        }
        return []
    }
    
}
