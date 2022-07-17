//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import ASKCore
import SwinjectAutoregistration

final class IOC: IOCService {
    
    override init() {
        super.init()
        registerViewModels()
        registerServices()
    }
    
}

private extension IOC {
    
    func registerViewModels() {
        container.autoregister(MiningViewModel.self, initializer: MiningViewModel.init)
    }
    
    func registerServices() {
        container.autoregister(OperationService.self, initializer: OperationService.init)
    }
    
}
