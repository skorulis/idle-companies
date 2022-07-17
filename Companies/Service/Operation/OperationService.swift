//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
    
    func start(_ op: Operation) {
        let prog = OperationProgress(operation: op, startTime: Date(), lastTick: Date())
        active = [prog]
    }
}
