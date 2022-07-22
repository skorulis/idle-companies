//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
    private let factory: PFactory
    private let timeProvider: PTimeProvider
    
    private lazy var miningService: MiningService = factory.resolve()
    private lazy var smithingService: SmithingService = factory.resolve()
    private lazy var marketingService: MarketingService = factory.resolve()
    
    public init(factory: PFactory, timeProvider: PTimeProvider) {
        self.factory = factory
        self.timeProvider = timeProvider
    }
    
    
}

// MARK: - Logic

extension OperationService {
    
    func stop(_ op: OperationProgress) {
        op.timer?.invalidate()
    }
    
    func start(_ op: POperation) {
        let time: TimeInterval = duration(op) / timeProvider.speed
        self.active.forEach { stop($0) }
        
        if !tryStart(op) {
            return
        }
        
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
    
    func duration(_ op: POperation) -> TimeInterval {
        switch op {
        case let mining as MiningOperation:
            return miningService.duration(mining)
        default:
            fatalError("Unknown type \(op)")
        }
    }
    
    func tryStart(_ op: POperation) -> Bool {
        return true
        /*switch op {
        case .smithing(let recipe):
            do {
                try smithingService.start(recipe)
            } catch {
                return false
            }
        default:
            break // No actions to do
        }
        return true*/
    }
    
    func finish(_ op: POperation) {
        switch op {
        case let mining as MiningOperation:
            miningService.onFinish(mining)
        default:
            fatalError("Unknown type \(op)")
        }
        self.objectWillChange.send()
    }
    
}
