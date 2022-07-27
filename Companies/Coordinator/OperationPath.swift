//  Created by Alexander Skorulis on 27/7/2022.

import Foundation
import SwiftUI

enum OperationPath: Hashable, Identifiable {
    case list
    case skillRoot(_ skill: Skill)
    
    case smelting
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .list:
            OperationListView(viewModel: coordinator.resolve())
        case .skillRoot(let skill):
            skillView(coordinator: coordinator, skill: skill)
        case .smelting:
            SmeltingView(viewModel: coordinator.resolve())
        }
    }
    
    @ViewBuilder
    func skillView(coordinator: GameCoordinator, skill: Skill) -> some View {
        switch skill {
        case .mining:
            MiningView(viewModel: coordinator.resolve())
        case .metallurgy:
            MetallurgyView(viewModel: coordinator.resolve())
        case .marketing:
            MarketingView(viewModel: coordinator.resolve())
        case .construction:
            ConstructionView(viewModel: coordinator.resolve())
        }
    }
    
    var id: String {
        String(describing: self)
    }
}
