//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore
import SwinjectAutoregistration

final class IOC: IOCService {
    
    override init() {
        super.init()
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
        container.autoregister(SmithingViewModel.self, initializer: SmithingViewModel.init)
    }
    
    func registerServices() {
        container.autoregister(OperationService.self, initializer: OperationService.init)
            .inObjectScope(.container)
        container.autoregister(MiningService.self, initializer: MiningService.init)
    }
    
    func registerStores() {
        container.autoregister(InventoryStore.self, initializer: InventoryStore.init)
            .inObjectScope(.container)
    }
    
}
