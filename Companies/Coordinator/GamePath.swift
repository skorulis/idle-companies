//  Created by Alexander Skorulis on 28/7/2022.

import Foundation
import SwiftUI

enum GamePath: CoordinatorPath, Hashable {
    case operation(_ path: OperationPath)
    case hq(_ path: HQPath)
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .operation(let path):
            path.render(coordinator: coordinator)
        case .hq(let path):
            path.render(coordinator: coordinator)
        }
    }
}
