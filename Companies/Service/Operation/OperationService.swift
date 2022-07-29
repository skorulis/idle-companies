//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore

// MARK: - Memory footprint

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
    private let factory: PFactory
    private let timeProvider: PTimeProvider
    let skillStore: SkillStore
    
    private lazy var miningService: MiningService = factory.resolve()
    private lazy var smithingService: SmithingService = factory.resolve()
    private lazy var marketingService: MarketingService = factory.resolve()
    private lazy var constructionService: ConstructionService = factory.resolve()
    
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
        case let mining as MiningActivity:
            return miningService.duration(mining)
        case let marketing as MarketingActivity:
            return marketingService.duration(marketing)
        case let smithing as SmeltingActivity:
            return smithingService.duration(smithing)
        case let typed as ConstructionContractActivity:
            return constructionService.duration(typed)
        case let typed as ConstructionMaterialActivity:
            return constructionService.duration(typed)
        default:
            fatalError("Unknown type \(op)")
        }
    }
    
    func tryStart(_ op: POperation) -> Bool {
        switch op {
        case let smithing as SmeltingActivity:
            do {
                try smithingService.start(smithing)
            } catch {
                return false
            }
        case let typed as ConstructionMaterialActivity:
            do {
                try constructionService.start(typed)
            } catch {
                return false
            }
        default:
            break // No actions to do
        }
        return true
    }
    
    func finish(_ op: POperation) {
        switch op {
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
        self.objectWillChange.send()
    }
    
}
