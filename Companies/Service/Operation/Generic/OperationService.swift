//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
    @Published var finishCount: Int = 0
    private let factory: PFactory
    private let timeProvider: PTimeProvider
    let skillStore: SkillStore
    
    public init(factory: PFactory,
                timeProvider: PTimeProvider,
                skillStore: SkillStore
    ) {
        self.factory = factory
        self.timeProvider = timeProvider
        self.skillStore = skillStore
    }
    
    
}

// MARK: - Logic

extension OperationService {
    
    func stop(_ op: OperationProgress) {
        op.timer?.invalidate()
    }
    
    func start<T: POperation>(_ op: T) {
        let time: TimeInterval = duration(op) / timeProvider.speed
        self.active.forEach { stop($0) }
        
        if !tryStart(op) {
            return
        }
        
        let timer: Timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
            self?.finish(op)
            self?.start(op) // Restart
        }
        
        let timing = TaskTiming(startTime: Date(), duration: time)
        let prog = OperationProgress(operation: op, timing: timing, lastTick: Date(), status: .active(timer: timer))
        
        active = [prog]
    }
    
    func maybeProgress<T: POperation>(_ op: T?) -> OperationProgress? {
        guard let op = op else { return nil }
        return active.first { progress in
            return progress.operation.matches(op)
        }
    }
    
    func pause() {
        let time = timeProvider.seconds
        for i in 0..<active.count {
            var task = active[i]
            task.timer?.invalidate()
            let remaining = time - task.timing.startTime.timeIntervalSince1970
            task.status = .paused(remaining: remaining)
            active[i] = task
        }
    }
    
    func resume() {
        
    }
    
    var nextToFinish: OperationProgress? {
        nextToFinish(before: timeProvider.seconds)
    }
    
    func nextToFinish(before: TimeInterval) -> OperationProgress? {
        let next = active.min { op1, op2 in
            return op1.finishTime < op2.finishTime
        }
        guard let next = next else {
            return nil
        }
        if next.finishTime < before {
            return next
        } else {
            return nil
        }
    }
    
}

// MARK: - Private logic

private extension OperationService {
    
    func duration<T: POperation>(_ op: T) -> TimeInterval {
        let service = factory.resolve(T.ServiceType.self)
        return service.stats(activity: op).duration
        
    }
    
    func tryStart<T: POperation>(_ op: T) -> Bool {
        let service = factory.resolve(T.ServiceType.self)
        do {
            try service.tryStart(activity: op)
        } catch {
            return false
        }
        
        return true
    }
    
    func finish<T: POperation>(_ op: T) {
        finishCount += 1
        print("Finish task \(finishCount)")
        let service = factory.resolve(T.ServiceType.self)
        service.finish(activity: op)
    }
    
}
