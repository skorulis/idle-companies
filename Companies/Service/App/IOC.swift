//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore
import SwinjectAutoregistration

final class IOC: IOCService {
    
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        registerCalculations()
        registerViewModels()
        registerServices()
        registerStores()
    }
    
}

private extension IOC {
    
    func registerViewModels() {
        container.autoregister(MiningViewModel.self, initializer: MiningViewModel.init)
        container.autoregister(InventoryViewModel.self, initializer: InventoryViewModel.init)
        container.autoregister(OperationListViewModel.self, initializer: OperationListViewModel.init)
        container.autoregister(SmeltingViewModel.self, initializer: SmeltingViewModel.init)
        container.autoregister(MetallurgyViewModel.self, initializer: MetallurgyViewModel.init)
        container.autoregister(MarketingViewModel.self, initializer: MarketingViewModel.init)
        container.autoregister(DebugViewModel.self, initializer: DebugViewModel.init)
        container.autoregister(ConstructionViewModel.self, initializer: ConstructionViewModel.init)
        
        container.autoregister(ToastPresentationService.self, initializer: ToastPresentationService.init)
            .inObjectScope(.container)
    }
    
    func registerServices() {
        container.autoregister(OperationService.self, initializer: OperationService.init)
            .inObjectScope(.container)
        container.autoregister(MiningService.self, initializer: MiningService.init)
        container.autoregister(MarketingService.self, initializer: MarketingService.init)
        container.autoregister(SmithingService.self, initializer: SmithingService.init)
        container.autoregister(RecipeService.self, initializer: RecipeService.init)
        #if DEBUG
        container.autoregister(PTimeProvider.self, initializer: DebugTimeProvider.init)
            .inObjectScope(.container)
        #else
        container.autoregister(PTimeProvider.self, initializer: TimeProvider.init)
        #endif
    }
    
    func registerStores() {
        container.autoregister(InventoryStore.self, initializer: InventoryStore.init)
            .inObjectScope(.container)
        container.autoregister(SkillStore.self, initializer: SkillStore.init)
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

    }
    
}
