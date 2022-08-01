//  Created by Alexander Skorulis on 1/8/2022.

import Foundation

// MARK: - Memory footprint

/// Record history of what happened to the user
final class ChangeHistoryService: ObservableObject {
    
    private (set) var current: ChangeHistory?
    @Published var toDispay: ChangeHistory?
    
    init() {
        
    }
}

// MARK: - Logic

extension ChangeHistoryService {

    /// Start a new block of change
    func start() {
        current = ChangeHistory()
    }
    
    func finish() {
        guard let current = current, !current.isEmpty else { return }
        toDispay = current
        self.current = nil
    }
    
    func change(item: ItemType, count: Int) {
        let before = current?.items[item] ?? 0
        current?.items[item] = before + count
    }
    
}
