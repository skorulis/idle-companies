//  Created by Alexander Skorulis on 27/7/2022.

import Foundation
import SwiftUI

enum OperationPath: Hashable, Identifiable {
    case list
    case mining
    case metallurgy
    case marketing
    case smelting
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .list:
            OperationListView(viewModel: coordinator.resolve())
        case .mining:
            MiningView(viewModel: coordinator.resolve())
        case .metallurgy:
            MetallurgyView(viewModel: coordinator.resolve())
        case .marketing:
            MarketingView(viewModel: coordinator.resolve())
        case .smelting:
            SmeltingView(viewModel: coordinator.resolve())
        }
    }
    
    var id: String {
        String(describing: self)
    }
}
