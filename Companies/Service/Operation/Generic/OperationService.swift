//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

final class OperationService {
    
    @Published var finishCount: Int = 0
    private let factory: PFactory
    private let timeProvider: PTimeProvider
    let skillStore: SkillStore
    let store: ActivityStore
    
    public init(factory: PFactory,
                timeProvider: PTimeProvider,
                skillStore: SkillStore,
                store: ActivityStore
    ) {
        self.factory = factory
        self.timeProvider = timeProvider
        self.skillStore = skillStore
        self.store = store
    }
    
    
}

// MARK: - Logic

extension OperationService {
    
    func stop(_ op: OperationProgress) {
        op.timer?.invalidate()
    }
    
    func start<T: POperation>(_ op: T) {
        if !tryStart(op) {
            return
        }
        
        let time: TimeInterval = duration(op) / timeProvider.speed
        store.active.forEach { stop($0) }
        
        let timing = TaskTiming(startTime: timeProvider.seconds, duration: time)
        var prog = OperationProgress(operation: op, timing: timing)
        prog.timer = createTimer(prog: prog)
        
        store.active = [prog]
    }
    
    private func createTimer(prog: OperationProgress) -> Timer {
        let remaining = prog.timing.remaining(timeProvider)
        let interval = max(remaining, 0.1)
        return Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            self?.finish(prog.operation)
            self?.start(prog.operation) // Restart
        }
    }
    
    func startBackground<T: POperation>(_ op: T, startTime: TimeInterval) {
        if !tryStart(op) {
            return
        }
        let time: TimeInterval = duration(op) / timeProvider.speed
        let timing = TaskTiming(startTime: startTime, duration: time)
        let prog = OperationProgress(operation: op, timing: timing)
        store.active = [prog]
    }
    
    func pause() {
        for i in 0..<store.active.count {
            var task = store.active[i]
            task.timer?.invalidate()
            task.timer = nil
            store.active[i] = task
        }
    }
    
    func resume() {
        for i in 0..<store.active.count {
            var task = store.active[i]
            task.timer = createTimer(prog: task)
            store.active[i] = task
        }
        print("Resumed \(store.active.count) tasks")
    }
    
    var nextToFinish: OperationProgress? {
        nextToFinish(before: timeProvider.seconds)
    }
    
    func nextToFinish(before: TimeInterval) -> OperationProgress? {
        let next = store.active.min { op1, op2 in
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

extension OperationService {
    
    private func duration<T: POperation>(_ op: T) -> TimeInterval {
        let service = factory.resolve(T.ServiceType.self)
        return service.stats(activity: op).duration
        
    }
    
    private func tryStart<T: POperation>(_ op: T) -> Bool {
        let service = factory.resolve(T.ServiceType.self)
        do {
            try service.tryStart(activity: op)
        } catch {
            return false
        }
        
        return true
    }
    
    internal func finish<T: POperation>(_ op: T) {
        finishCount += 1
        print("Finish task \(finishCount)")
        let service = factory.resolve(T.ServiceType.self)
        service.finish(activity: op)
        store.remove(op)
    }
    
}
