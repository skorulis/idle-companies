//  Created by Alexander Skorulis on 20/7/2022.

import Combine
import Foundation

final class SmithingViewModel: ObservableObject {

    private let operations: OperationService
    private var subscribers: Set<AnyCancellable> = []
    
    init(operations: OperationService) {
        self.operations = operations
        
        operations.objectWillChange
            .sink { [unowned self] _ in
                self.objectWillChange.send()
            }
            .store(in: &subscribers)
    }
}
