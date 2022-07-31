//  Created by Alexander Skorulis on 31/7/2022.

import Foundation

final class OfflineService {
    
    private let operationService: OperationService
    private let timeProvider: PTimeProvider
    private var pauseTime: TimeInterval?
    
    init(operationService: OperationService, timeProvider: PTimeProvider) {
        self.timeProvider = timeProvider
        self.operationService = operationService
    }
    
}


extension OfflineService: PBackgroundListener {
    
    func didEnterBackground() {
        pauseTime = timeProvider.seconds
        operationService.pause()
    }
    
    func willEnterForeground() {
        guard let pauseTime = pauseTime else { return }
        self.pauseTime = nil
        let elapsed = Date().timeIntervalSince1970 - pauseTime
        
    }
    
    func advanceTask() {
        
    }
    
}
