//  Created by Alexander Skorulis on 31/7/2022.

import Foundation

// MARK: - Memory footprint

final class OfflineService {
    
    private let operationService: OperationService
    private let timeProvider: PTimeProvider
    private let changeService: ChangeHistoryService
    private var pauseTime: TimeInterval?
    
    init(operationService: OperationService,
         timeProvider: PTimeProvider,
         changeService: ChangeHistoryService
    ) {
        self.timeProvider = timeProvider
        self.operationService = operationService
        self.changeService = changeService
    }
    
}

// MARK: - Logic (private)

private extension OfflineService {
    
    func advanceTasks() {
        while let next = operationService.nextToFinish {
            let time = next.finishTime
            operationService.finish(next.operation)
            operationService.startBackground(next.operation, startTime: time)
        }
        changeService.finish()
    }
}

// MARK: - PBackgroundListener

extension OfflineService: PBackgroundListener {
    
    func didEnterBackground() {
        changeService.start()
        pauseTime = timeProvider.seconds
        operationService.pause()
    }
    
    func willEnterForeground() {
        let pauseTime = self.pauseTime ?? self.operationService.store.lastStartTime ?? 0
        self.pauseTime = nil
        let elapsed = Date().timeIntervalSince1970 - pauseTime
        print("Finished offline after \(elapsed)")
        advanceTasks()
        operationService.resume()
    }
    
    
    
}
