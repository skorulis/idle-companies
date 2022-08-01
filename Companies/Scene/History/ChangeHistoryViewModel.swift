//  Created by Alexander Skorulis on 1/8/2022.

import Foundation

// MARK: - Memory footprint

final class ChangeHistoryViewModel: ObservableObject {
    
    private let changeService: ChangeHistoryService
    
    let itemList: [ItemCount]
    
    init(changeService: ChangeHistoryService) {
        self.changeService = changeService
        itemList = changeService.toDispay?.items.map({ (key, value) in
            return ItemCount(type: key, count: value)
        }) ?? []
    }
    
}

// MARK: - Computed value

extension ChangeHistoryViewModel {
    
    
    
}

// MARK: - Logic

extension ChangeHistoryViewModel {
    
    func clearHistory() {
        changeService.toDispay = nil
    }
}
