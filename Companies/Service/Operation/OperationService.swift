//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
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
        let service = factory.resolve(T.ServiceType.self)
        service.finish(activity: op)
        /*switch op {
        case let mining as MiningActivity:
            miningService.onFinish(mining)
        case let marketing as MarketingActivity:
            marketingService.onFinish(marketing)
        case let smithing as SmeltingActivity:
            smithingService.onFinish(smithing)
        case let typed as ConstructionContractActivity:
            constructionService.onFinish(typed)
        default:
            fatalError("Unknown type \(op)")
        }
        skillStore.addXP(skill: op.skill, xp: op.baseXP, operationID: op.id)
        self.objectWillChange.send()*/
    }
    
}
