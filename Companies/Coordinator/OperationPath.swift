//  Created by Alexander Skorulis on 27/7/2022.

import Foundation
import SwiftUI

enum OperationPath: Hashable, Identifiable {
    case list
    case skillRoot(_ skill: Skill)
    
    case smelting
    case construction(_ type: ConstructionSubType)
    
    var id: String {
        String(describing: self)
    }
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .list:
            OperationListView(viewModel: coordinator.resolve())
        case .skillRoot(let skill):
            skillView(coordinator: coordinator, skill: skill)
        case .smelting:
            SmeltingView(viewModel: coordinator.resolve())
        case .construction(let type):
            constructionView(coordinator: coordinator, type: type)
        }
    }
    
    @ViewBuilder
    private func skillView(coordinator: GameCoordinator, skill: Skill) -> some View {
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
    
    @ViewBuilder
    private func constructionView(coordinator: GameCoordinator, type: ConstructionSubType) -> some View {
        switch type {
        case .materials:
            EmptyView()
        case .buildings:
            EmptyView()
        case .contracts:
            ConstructionContractsView(viewModel: coordinator.resolve())
        }
    }
    
    
    
}
