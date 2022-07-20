//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
    private let factory: PFactory
    
    private lazy var miningService: MiningService = factory.resolve()
    
    public init(factory: PFactory) {
        self.factory = factory
    }
    
    
}

// MARK: - Logic

extension OperationService {
    
    func stop(_ op: OperationProgress) {
        op.timer?.invalidate()
    }
    
    func start(_ op: Operation) {
        let time: TimeInterval = duration(op)
        self.active.forEach { stop($0) }
        
        let timing = TaskTiming(startTime: Date(), duration: time)
        var prog = OperationProgress(operation: op, timing: timing, lastTick: Date())
        
        let timer: Timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
            self?.finish(op)
            self?.start(op) // Restart
        }
        
        prog.timer = timer
        active = [prog]
    }
    
    
}

// MARK: - Private logic

extension OperationService {
    
    func duration(_ op: Operation) -> TimeInterval {
        switch op {
        case .mining(let type):
            return miningService.duration(type)
        }
    }
    
    func finish(_ op: Operation) {
        switch op {
        case .mining(let type):
            miningService.onFinish(type)
        }
        self.objectWillChange.send()
    }
    
}
