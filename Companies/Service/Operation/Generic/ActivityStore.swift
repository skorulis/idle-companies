//  Created by Alexander Skorulis on 1/8/2022.

import Foundation

final class ActivityStore: ObservableObject {
    
    private let diskStore: PKeyValueStore
    
    @Published var active: [OperationProgress] = []
    
    init(diskStore: PKeyValueStore) {
        self.diskStore = diskStore
    }
}

// MARK: - Logic

extension ActivityStore {
    
    func maybeProgress<T: POperation>(_ op: T?) -> OperationProgress? {
        guard let op = op else { return nil }
        return active.first { progress in
            return progress.operation.matches(op)
        }
    }
}
