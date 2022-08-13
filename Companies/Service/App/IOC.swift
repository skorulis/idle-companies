//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore
import SwinjectAutoregistration

final class IOC: IOCService {
    
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        registerBehaviors()
        registerCalculations()
        registerCoordinators()
        registerViewModels()
        registerServices()
        registerActivityServices()
        registerStores()
        
// Prevent some things happening while running tests
#if DEBUG
        if !Self.isTesting || purpose == .testing {
            startup()
        }
#endif
    }
    
    static var isTesting: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
}

private extension IOC {
    
    func startup() {
        resolve(TransientValuesService.self).calculateValues() // Make sure all values are resolved at startup
    }
    
    func registerCoordinators() {
        container.autoregister(GameCoordinator.self, argument: GamePath.self, initializer: GameCoordinator.init)
    }
    
    func registerViewModels() {
        container.autoregister(MiningViewModel.self, initializer: MiningViewModel.init)
        container.autoregister(InventoryViewModel.self, initializer: InventoryViewModel.init)
        container.autoregister(OperationListViewModel.self, initializer: OperationListViewModel.init)
        container.autoregister(SmeltingViewModel.self, initializer: SmeltingViewModel.init)
        container.autoregister(MetallurgyViewModel.self, initializer: MetallurgyViewModel.init)
        container.autoregister(MarketingViewModel.self, initializer: MarketingViewModel.init)
        container.autoregister(DebugViewModel.self, initializer: DebugViewModel.init)
        container.autoregister(ConstructionViewModel.self, initializer: ConstructionViewModel.init)
        container.autoregister(ConstructionContractsViewModel.self, initializer: ConstructionContractsViewModel.init)
        container.autoregister(HeadquartersViewModel.self, initializer: HeadquartersViewModel.init)
        container.autoregister(HQUpgradeViewModel.self, initializer: HQUpgradeViewModel.init)
        container.autoregister(ManageEnhancementsViewModel.self, initializer: ManageEnhancementsViewModel.init)
        container.autoregister(ConstructionMaterialsViewModel.self, initializer: ConstructionMaterialsViewModel.init)
        container.autoregister(ChangeHistoryViewModel.self, initializer: ChangeHistoryViewModel.init)
        container.autoregister(HumanResourcesViewModel.self, initializer: HumanResourcesViewModel.init)
        container.autoregister(RecruitingViewModel.self, initializer: RecruitingViewModel.init)
        container.autoregister(EducationViewModel.self, initializer: EducationViewModel.init)
        container.autoregister(MilitaryViewModel.self, initializer: MilitaryViewModel.init)
        container.autoregister(MilitaryTrainingViewModel.self, initializer: MilitaryTrainingViewModel.init)
        
        container.autoregister(ToastPresentationService.self, initializer: ToastPresentationService.init)
            .inObjectScope(.container)
    }
    
    func registerServices() {
        container.autoregister(OperationService.self, initializer: OperationService.init)
            .inObjectScope(.container)
        container.autoregister(OfflineService.self, initializer: OfflineService.init)
            .inObjectScope(.container)
        container.autoregister(RecipeService.self, initializer: RecipeService.init)
        
        container.autoregister(ChangeHistoryService.self, initializer: ChangeHistoryService.init)
            .inObjectScope(.container)
        container.autoregister(TransientValuesService.self, initializer: TransientValuesService.init)
            .inObjectScope(.container)
        container.autoregister(EnhancementService.self, initializer: EnhancementService.init)
        
        #if DEBUG
        container.autoregister(DebugTimeProvider.self, initializer: DebugTimeProvider.init)
            .forward(from: PTimeProvider.self, container: container)
            .inObjectScope(.container)
        #else
        container.autoregister(PTimeProvider.self, initializer: TimeProvider.init)
        #endif
    }
    
    func registerActivityServices() {
        container.autoregister(MiningActivity.Service.self, initializer: MiningActivity.Service.init)
        container.autoregister(MarketingActivity.Service.self, initializer: MarketingActivity.Service.init)
        container.autoregister(SmeltingActivity.Service.self, initializer: SmeltingActivity.Service.init)
        container.autoregister(ConstructionMaterialActivity.Service.self, initializer: ConstructionMaterialActivity.Service.init)
        container.autoregister(ConstructionContractActivity.Service.self, initializer: ConstructionContractActivity.Service.init)
        container.autoregister(RecruitingActivity.Service.self, initializer: RecruitingActivity.Service.init)
        container.autoregister(EducationActivity.Service.self, initializer: EducationActivity.Service.init)
    }
    
    func registerStores() {
        container.autoregister(InventoryStore.self, initializer: InventoryStore.init)
            .inObjectScope(.container)
        container.autoregister(SkillStore.self, initializer: SkillStore.init)
            .inObjectScope(.container)
        container.autoregister(CompanyStore.self, initializer: CompanyStore.init)
            .inObjectScope(.container)
        container.autoregister(UIHistoryStore.self, initializer: UIHistoryStore.init)
            .inObjectScope(.container)
        container.autoregister(AppStateStore.self, initializer: AppStateStore.init)
            .inObjectScope(.container)
        container.autoregister(ActivityStore.self, initializer: ActivityStore.init)
            .inObjectScope(.container)
        container.autoregister(TransientValuesStore.self, initializer: TransientValuesStore.init)
            .inObjectScope(.container)
        
        switch purpose {
        case .testing:
            container.autoregister(PKeyValueStore.self, initializer: InMemoryDefaults.init)
                .inObjectScope(.container)
        case .normal:
            container.autoregister(PKeyValueStore.self, initializer: UserDefaults.init)
                .inObjectScope(.container)
        }
    }
    
    func registerCalculations() {
        container.autoregister(XPLevelCalculation.self, initializer: XPLevelCalculation.init)
        container.autoregister(EnhancementCalculation.self, initializer: EnhancementCalculation.init)
    }
    
    func registerBehaviors() {
        container.addBehavior(InstanceAggregation<PBackgroundListener>(isChild: { $0 is PBackgroundListener.Type }))
    }
    
}

// MARK: Testing

extension IOC {
    
    var emptyCoordinator: GameCoordinator {
        resolve(GameCoordinator.self, argument: GamePath.empty)
    }
}
